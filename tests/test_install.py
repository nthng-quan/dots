import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

class InstallTests(unittest.TestCase):
    def run_install(self, home, *args, check=True):
        return subprocess.run([str(ROOT / 'install.sh'), '--target', str(home), *args], check=check, capture_output=True, text=True)

    def test_backup_links_repeat_and_unrelated_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            h = Path(tmp)
            (h / '.zshrc').write_text('original')
            (h / '.gitconfig').symlink_to('/missing-config')
            (h / '.config/i3').mkdir(parents=True)
            (h / '.config/i3/local.sh').write_text('private')
            self.run_install(h, '--dry-run')
            self.assertEqual((h / '.zshrc').read_text(), 'original')
            self.assertFalse((h / '.local').exists())
            self.run_install(h)
            for src in (ROOT / 'home').rglob('*'):
                if src.is_file():
                    dest = h / src.relative_to(ROOT / 'home')
                    self.assertTrue(dest.is_symlink())
                    self.assertEqual(dest.resolve(), src)
            backups = list((h / '.local/state/dotfiles/backups').iterdir())
            self.assertEqual(len(backups), 1)
            self.assertEqual((backups[0] / '.zshrc').read_text(), 'original')
            self.assertEqual(os.readlink(backups[0] / '.gitconfig'), '/missing-config')
            self.assertEqual((h / '.config/i3/local.sh').read_text(), 'private')
            self.run_install(h)
            self.assertEqual(len(list((h / '.local/state/dotfiles/backups').iterdir())), 1)

    def test_refuses_symlinked_parent(self):
        with tempfile.TemporaryDirectory() as tmp, tempfile.TemporaryDirectory() as other:
            h = Path(tmp)
            (h / '.config').symlink_to(other)
            result = self.run_install(h, check=False)
            self.assertNotEqual(result.returncode, 0)
            self.assertEqual(list(Path(other).iterdir()), [])

    def test_cli_profile_links_only_terminal_configs(self):
        with tempfile.TemporaryDirectory() as tmp:
            h = Path(tmp)
            self.run_install(h, '--profile', 'cli')
            for name in ('.zshrc', '.zsh_aliases', '.tmux.conf', '.gitconfig', '.config/git/ignore', '.config/nvim/init.lua'):
                self.assertTrue((h / name).is_symlink(), name)
            for name in ('i3', 'i3blocks', 'rofi', 'dunst', 'picom', 'alacritty'):
                self.assertFalse((h / '.config' / name).exists(), name)
