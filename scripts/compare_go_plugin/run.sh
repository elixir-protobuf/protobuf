#!/usr/bin/env bash
# Compare this repo's protoc-gen-elixir escript against the TrogonStack Go
# reimplementation (https://github.com/TrogonStack/protoc-gen).
#
# Generates:
#   1) mix.exs gen_test_protos / Trogon golden fixtures
#   2) every plugin flag solo
#   3) kitchen-sink combos (incl. full all-flags with ofpm+grpc)
# then formats both trees with Code.format_string!/1 (format_trees.exs) and
# asserts byte-identical output via compare_tree.py (blank files treated as
# absent).
#
# Required:
#   - protoc on PATH
#   - elixir on PATH
#   - PROTOC_GEN_ELIXIR_ESCRIPT  path to a built escript from this repo
#   - PROTOC_GEN_ELIXIR_GO      path to the Go protoc-gen-elixir binary
#   - GOOGLE_PROTOBUF_SRC       path to protobuf src/ (descriptor.proto), usually
#                               deps/google_protobuf/src after `mix deps.get`
#

# Usage (from repo root, after mix deps.get && MIX_ENV=prod mix escript.build):
#   PROTOC_GEN_ELIXIR_ESCRIPT=./protoc-gen-elixir \
#   PROTOC_GEN_ELIXIR_GO=/path/to/protoc-gen-elixir \
#   GOOGLE_PROTOBUF_SRC=deps/google_protobuf/src \
#   ./scripts/compare_go_plugin/run.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$ROOT"

: "${PROTOC_GEN_ELIXIR_ESCRIPT:?set PROTOC_GEN_ELIXIR_ESCRIPT}"
: "${PROTOC_GEN_ELIXIR_GO:?set PROTOC_GEN_ELIXIR_GO}"
: "${GOOGLE_PROTOBUF_SRC:?set GOOGLE_PROTOBUF_SRC}"

PROTO_DIR="$ROOT/test/protobuf/protoc/proto"
WORKDIR="$(mktemp -d -t protobuf-elixir-go-compare.XXXXXX)"
trap 'rm -rf "$WORKDIR"' EXIT

command -v protoc >/dev/null || { echo "protoc not on PATH" >&2; exit 1; }
command -v elixir >/dev/null || { echo "elixir not on PATH" >&2; exit 1; }
[[ -f "$PROTOC_GEN_ELIXIR_ESCRIPT" ]] || {
  echo "escript not found: $PROTOC_GEN_ELIXIR_ESCRIPT" >&2
  exit 1
}
[[ -f "$PROTOC_GEN_ELIXIR_GO" ]] || {
  echo "Go plugin not found: $PROTOC_GEN_ELIXIR_GO" >&2
  exit 1
}
[[ -d "$GOOGLE_PROTOBUF_SRC" ]] || {
  echo "GOOGLE_PROTOBUF_SRC is not a directory: $GOOGLE_PROTOBUF_SRC" >&2
  exit 1
}

chmod +x "$PROTOC_GEN_ELIXIR_ESCRIPT" "$PROTOC_GEN_ELIXIR_GO" 2>/dev/null || true

echo "escript: $PROTOC_GEN_ELIXIR_ESCRIPT ($("$PROTOC_GEN_ELIXIR_ESCRIPT" --version 2>/dev/null || echo '?'))"
echo "go:      $PROTOC_GEN_ELIXIR_GO ($("$PROTOC_GEN_ELIXIR_GO" --version 2>/dev/null || echo '?'))"
echo "protoc:  $(protoc --version)"
echo "workdir: $WORKDIR"

# gen_both <name> <elixir_opt> <proto files relative to PROTO_DIR...>
gen_both() {
  local name="$1"
  local opt="$2"
  shift 2

  local out_e="$WORKDIR/$name/escript"
  local out_g="$WORKDIR/$name/go"
  mkdir -p "$out_e" "$out_g"

  local elixir_out_e="$out_e"
  local elixir_out_g="$out_g"
  if [[ -n "$opt" ]]; then
    elixir_out_e="${opt}:${out_e}"
    elixir_out_g="${opt}:${out_g}"
  fi

  # Pass basenames with -I PROTO_DIR (same as TrogonStack gen_goldens.sh).
  # Include paths mirror mix.exs gen_test_protos.
  # `|| return`: run_case invokes gen_both inside `set +e`, so without explicit
  # propagation a failed protoc would be masked by the last command's status.
  protoc \
    -I "$GOOGLE_PROTOBUF_SRC" \
    -I "$ROOT/src" \
    -I "$PROTO_DIR" \
    --plugin="protoc-gen-elixir=$PROTOC_GEN_ELIXIR_ESCRIPT" \
    --elixir_out="$elixir_out_e" \
    "$@" || return 1

  protoc \
    -I "$GOOGLE_PROTOBUF_SRC" \
    -I "$ROOT/src" \
    -I "$PROTO_DIR" \
    --plugin="protoc-gen-elixir=$PROTOC_GEN_ELIXIR_GO" \
    --elixir_out="$elixir_out_g" \
    "$@" || return 1

  elixir "$SCRIPT_DIR/format_trees.exs" "$out_e" "$out_g"
}

compare_tree() {
  local name="$1"
  python3 "$SCRIPT_DIR/compare_tree.py" \
    "$name" "$WORKDIR/$name/escript" "$WORKDIR/$name/go"
}

FAILED=0
run_case() {
  local name="$1"
  local opt="$2"
  shift 2
  echo
  echo "========== $name =========="
  echo "opt: ${opt:-"(none)"}"
  echo "protos: $*"

  # Avoid `if gen_both`: bash disables set -e inside conditional contexts.
  set +e
  gen_both "$name" "$opt" "$@"
  local gen_status=$?
  set -e
  if [[ "$gen_status" -ne 0 ]]; then
    echo "FAIL: generation for $name" >&2
    FAILED=1
    return
  fi

  set +e
  compare_tree "$name"
  local cmp_status=$?
  set -e
  if [[ "$cmp_status" -ne 0 ]]; then
    FAILED=1
  fi
}

# ---------------------------------------------------------------------------
# 1) Fixture scenarios: mirrors mix.exs gen_test_protos / Trogon gen_goldens.sh
# ---------------------------------------------------------------------------
run_case extension "include_docs=true" extension.proto
run_case package_prefix "package_prefix=my,include_docs=true" test.proto service.proto
run_case gen_descriptors "gen_descriptors=true,include_docs=true" custom_options.proto
run_case no_package "include_docs=true" no_package.proto
run_case full_name "gen_proto_source=true,include_docs=true" full_name.proto
run_case grpc "plugins=grpc,include_docs=true" test.proto service.proto
run_case grpc_proto_source "plugins=grpc,gen_proto_source=true" test.proto service.proto
run_case transform_module "transform_module=My.App.Transform" test.proto
run_case one_file_per_module "one_file_per_module=true,include_docs=true" test.proto service.proto

# ---------------------------------------------------------------------------
# 2) Every plugin flag solo (same corpus so diffs are attributable to the flag)
# ---------------------------------------------------------------------------
run_case flag_none "" test.proto service.proto
run_case flag_plugins_grpc "plugins=grpc" test.proto service.proto
run_case flag_gen_descriptors "gen_descriptors=true" test.proto service.proto
run_case flag_package_prefix "package_prefix=MyPrefix" test.proto service.proto
run_case flag_transform_module "transform_module=MyApp.Transform" test.proto service.proto
run_case flag_one_file_per_module "one_file_per_module=true" test.proto service.proto
run_case flag_include_docs "include_docs=true" test.proto service.proto
run_case flag_gen_proto_source "gen_proto_source=true" test.proto service.proto

# ---------------------------------------------------------------------------
# 3) Kitchen-sink combos
# ---------------------------------------------------------------------------
run_case all_flags_no_ofpm \
  "plugins=grpc,gen_descriptors=true,package_prefix=MyPrefix,transform_module=MyApp.Transform,include_docs=true,gen_proto_source=true" \
  test.proto service.proto

run_case all_flags_no_grpc \
  "gen_descriptors=true,package_prefix=MyPrefix,transform_module=MyApp.Transform,one_file_per_module=true,include_docs=true,gen_proto_source=true" \
  test.proto service.proto

run_case one_file_per_module_grpc \
  "one_file_per_module=true,plugins=grpc,include_docs=true" \
  test.proto service.proto

run_case all_flags \
  "plugins=grpc,gen_descriptors=true,package_prefix=MyPrefix,transform_module=MyApp.Transform,one_file_per_module=true,include_docs=true,gen_proto_source=true" \
  test.proto service.proto

echo
if [[ "$FAILED" -eq 0 ]]; then
  echo "ALL COMPARE CASES OK"
else
  echo "SOME COMPARE CASES FAILED" >&2
  exit 1
fi
