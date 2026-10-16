#!/usr/bin/env python3
"""Install locked plugin repositories and checksummed release archives."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile
import urllib.request
import zipfile

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--dry-run', action='store_true')
p.add_argument('--nvim-only', action='store_true')
p.add_argument('--profile', choices=('desktop', 'cli'), default='desktop')
a = p.parse_args()
root = Path(__file__).resolve().parents[1]
home = Path.home()
lockfile = 'nvim-plugins.lock.json' if a.nvim_only else 'plugins.lock.json'
for item in json.loads((root / lockfile).read_text()):
    dest = home / item['path']
    print(f"Plugin {item['repo']} @ {item['commit']}")
    if a.dry_run:
        continue
    if not dest.exists():
        dest.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(['git', 'clone', 'https://github.com/' + item['repo'] + '.git', str(dest)], check=True)
    if subprocess.check_output(['git', '-C', str(dest), 'status', '--porcelain', '--untracked-files=no'], text=True).strip():
        raise SystemExit(f'Uncommitted changes in {dest}; refusing to overwrite')
    current = subprocess.check_output(['git', '-C', str(dest), 'rev-parse', 'HEAD'], text=True).strip()
    if current == item['commit']:
        continue
    subprocess.run(['git', '-C', str(dest), 'fetch', 'origin', item['commit']], check=True)
    subprocess.run(['git', '-C', str(dest), 'checkout', '--detach', item['commit']], check=True)
releases = [] if a.nvim_only else json.loads((root / 'releases.lock.json').read_text())
for item in releases:
    if a.profile == 'cli' and item.get('desktop_only'):
        continue
    print(f"Release {item['name']} @ {item['version']}")
    if a.dry_run:
        continue
    base = home / '.local/share/dotfiles' / item['name']
    marker = base / '.release-sha256'
    bindir = home / '.local/bin'
    # Check conflicts before replacing an existing release directory.
    for command in item['commands']:
        target = bindir / command
        if target.exists() and not target.is_symlink():
            raise SystemExit(f'Refusing to replace existing executable: {target}')
    if marker.exists() and marker.read_text().strip() == item['sha256']:
        if item['name'] == 'font':
            fontdir = home / '.local/share/fonts/IosevkaNerdFont'
            if any(fontdir.glob('*.ttf')):
                continue
        else:
            sources = [(command, base / ('bin/' if item['name'] == 'nvim' else '') / command)
                       for command in item['commands']]
            if all(source.is_file() for _, source in sources):
                bindir.mkdir(parents=True, exist_ok=True)
                for command, source in sources:
                    target = bindir / command
                    if target.is_symlink() and target.resolve() == source:
                        continue
                    target.unlink(missing_ok=True)
                    target.symlink_to(source)
                continue
    with tempfile.TemporaryDirectory() as tmp:
        archive = Path(tmp) / 'archive'
        urllib.request.urlretrieve(item['url'], archive)
        if hashlib.sha256(archive.read_bytes()).hexdigest() != item['sha256']:
            raise SystemExit('Checksum mismatch: ' + item['name'])
        unpacked = Path(tmp) / 'unpacked'
        unpacked.mkdir()
        if item['name'] == 'font':
            with zipfile.ZipFile(archive) as z:
                for name in z.namelist():
                    if name.endswith('.ttf'):
                        (unpacked / Path(name).name).write_bytes(z.read(name))
            dest = home / '.local/share/fonts/IosevkaNerdFont'
            dest.mkdir(parents=True, exist_ok=True)
            for font in unpacked.iterdir():
                shutil.copy2(font, dest / font.name)
            subprocess.run(['fc-cache', '-f'], check=True)
            base.mkdir(parents=True, exist_ok=True)
        else:
            if item['url'].endswith('.zip'):
                with zipfile.ZipFile(archive) as z:
                    for info in z.infolist():
                        path = Path(info.filename)
                        if path.is_absolute() or '..' in path.parts:
                            raise SystemExit('Unsafe archive path')
                    z.extractall(unpacked)
                for command in item['commands']:
                    for executable in unpacked.rglob(command):
                        executable.chmod(0o755)
            else:
                with tarfile.open(archive) as t:
                    t.extractall(unpacked, filter='data')
            if base.exists():
                shutil.rmtree(base)
            base.parent.mkdir(parents=True, exist_ok=True)
            content = next(unpacked.iterdir()) if item['name'] in ('nvim', 'yazi') else unpacked
            shutil.copytree(content, base)
            bindir = home / '.local/bin'
            bindir.mkdir(parents=True, exist_ok=True)
            for command in item['commands']:
                source = base / ('bin/' if item['name'] == 'nvim' else '') / command
                target = bindir / command
                if target.exists() and not target.is_symlink():
                    raise SystemExit(f'Refusing to replace existing executable: {target}')
                target.unlink(missing_ok=True)
                target.symlink_to(source)
        marker.write_text(item['sha256'] + '\n')
