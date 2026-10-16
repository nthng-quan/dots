#!/usr/bin/env python3
"""Link individual files; preserve unrelated configuration and back up conflicts."""
import argparse
import datetime
import os
from pathlib import Path
import shutil

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--dry-run', action='store_true')
parser.add_argument('--target', type=Path, default=Path.home())
a = parser.parse_args()
root = Path(__file__).resolve().parents[1]
target = a.target.expanduser().absolute()
backup = target / '.local/state/dotfiles/backups' / datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f')
for source in sorted((root / 'home').rglob('*')):
    if not source.is_file():
        continue
    rel = source.relative_to(root / 'home')
    dest = target / rel
    # Never follow a symlinked parent and accidentally change another tree.
    for parent in dest.parents:
        if parent == target:
            break
        if parent.is_symlink():
            raise SystemExit(f'Refusing symlinked parent: {parent}')
    if dest.is_symlink() and dest.resolve() == source:
        continue
    print(f'Link {rel}')
    if a.dry_run:
        continue
    if os.path.lexists(dest):
        saved = backup / rel
        saved.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(dest), str(saved))
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.symlink_to(source)
if not a.dry_run:
    print(f'Backups (if needed): {backup}')
