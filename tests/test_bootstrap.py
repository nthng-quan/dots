import hashlib
import io
import json
import os
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name) / 'repo'
        self.home = Path(self.tmp.name) / 'home'
        (self.root / 'scripts').mkdir(parents=True)
        self.home.mkdir()
        shutil.copy2(ROOT / 'scripts/bootstrap.py', self.root / 'scripts/bootstrap.py')
        (self.root / 'plugins.lock.json').write_text('[]')
        self.archive = Path(self.tmp.name) / 'release.tar.gz'
        with tarfile.open(self.archive, 'w:gz') as tar:
            data = b'#!/bin/sh\necho fixture\n'
            info = tarfile.TarInfo('starship')
            info.size = len(data)
            info.mode = 0o755
            tar.addfile(info, io.BytesIO(data))
        item = dict(name='starship', version='test', url=self.archive.as_uri(),
                    sha256=hashlib.sha256(self.archive.read_bytes()).hexdigest(), commands=['starship'])
        (self.root / 'releases.lock.json').write_text(json.dumps([item]))

    def run_bootstrap(self, *args, check=True):
        return subprocess.run(['python3', str(self.root / 'scripts/bootstrap.py'), *args],
                              env=dict(os.environ, HOME=str(self.home)),
                              capture_output=True, text=True, check=check)

    def test_cli_profile_skips_desktop_only_release(self):
        items = json.loads((self.root / 'releases.lock.json').read_text())
        items.append(dict(name='font', version='test', url='file:///nonexistent.zip', sha256='0', commands=[], desktop_only=True))
        (self.root / 'releases.lock.json').write_text(json.dumps(items))
        result = self.run_bootstrap('--profile', 'cli')
        self.assertNotIn('font', result.stdout)
        self.assertTrue((self.home / '.local/bin/starship').is_symlink())

    def test_repeat_repairs_missing_link_without_downloading(self):
        self.run_bootstrap()
        link = self.home / '.local/bin/starship'
        self.assertTrue(link.is_symlink())
        link.unlink()
        self.archive.unlink()
        self.run_bootstrap()
        self.assertTrue(link.is_symlink())
        self.assertEqual(subprocess.check_output([str(link)], text=True).strip(), 'fixture')

    def test_conflict_preserves_existing_installation(self):
        self.run_bootstrap()
        link = self.home / '.local/bin/starship'
        link.unlink()
        link.write_text('personal executable')
        base = self.home / '.local/share/dotfiles/starship'
        (base / '.release-sha256').write_text('old release')
        (base / 'keep').write_text('preserve me')
        result = self.run_bootstrap(check=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Refusing to replace', result.stderr)
        self.assertEqual(link.read_text(), 'personal executable')
        self.assertEqual((base / 'keep').read_text(), 'preserve me')
