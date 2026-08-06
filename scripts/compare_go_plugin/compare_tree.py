#!/usr/bin/env python3
"""Assert two generated trees are byte-identical.

Usage: compare_tree.py <case-name> <escript-out-dir> <go-out-dir>

Exits non-zero if any file differs, is missing, or is extra.
"""
import hashlib
import sys
from pathlib import Path

name, e_root, g_root = sys.argv[1], Path(sys.argv[2]), Path(sys.argv[3])


def is_blank(path: Path) -> bool:
    # After format, empty escript stubs are often a single "\n".
    return path.read_text().strip() == ""


# The escript sometimes emits an empty .pb.ex for service-only protos when
# plugins=grpc is off; the Go plugin omits those files. Treat blank ≡ absent.
def index(root: Path) -> dict:
    out = {}
    for f in root.rglob("*.ex"):
        if is_blank(f):
            continue
        out[f.relative_to(root)] = f
    return out


e_files = index(e_root)
g_files = index(g_root)

ok = bad = missing = 0
for rel, ep in sorted(e_files.items(), key=lambda kv: str(kv[0])):
    gp = g_files.get(rel)
    if gp is None:
        missing += 1
        print(f"  MISSING in go: {rel}")
        continue
    if ep.read_bytes() == gp.read_bytes():
        ok += 1
    else:
        bad += 1
        print(f"  DIFF: {rel}")

extra = sorted(set(g_files) - set(e_files), key=str)
for rel in extra:
    print(f"  EXTRA in go: {rel}")


def tree_sha(files: dict) -> str:
    h = hashlib.sha256()
    for rel in sorted(files, key=str):
        h.update(str(rel).encode() + b"\0")
        h.update(files[rel].read_bytes() + b"\0")
    return h.hexdigest()


print(
    f"[{name}] files escript={len(e_files)} go={len(g_files)} "
    f"identical={ok}/{len(e_files)} differ={bad} missing={missing} extra={len(extra)}"
)
print(f"[{name}] sha escript={tree_sha(e_files)}")
print(f"[{name}] sha go     ={tree_sha(g_files)}")
if bad or missing or extra:
    raise SystemExit(1)
print(f"[{name}] OK")
