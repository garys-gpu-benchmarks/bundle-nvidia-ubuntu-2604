#!/usr/bin/env bash
# run.sh - list, fetch and run the benchmarks in this bundle.
#   ./run.sh list | ./run.sh <NNN> [--baseline|--extended] | ./run.sh all
set -uo pipefail
cd "$(dirname "$0")"
find_dir() { local d; for d in "$1"-*/; do [ -d "$d" ] && { echo "${d%/}"; return; }; done; }
ensure() {
  if [ ! -e "$1/.git" ]; then
    echo ">> fetching $(basename "$1")"
    git submodule update --init -- "$1" || return 1
  fi
}
run_one() {
  local n=$1; shift
  local d; d=$(find_dir "$n")
  [ -n "$d" ] || { echo "No benchmark $n in this bundle (try ./run.sh list)"; return 2; }
  ensure "$d" || return 1
  mkdir -p results
  local logf="results/$(basename "$d")-$(date +%Y%m%d-%H%M%S).log"
  echo ">> $(basename "$d"): setup"
  ( cd "$d" && bash ./setup.sh ) 2>&1 | tee "$logf"; [ "${PIPESTATUS[0]}" -eq 0 ] || return 1
  echo ">> $(basename "$d"): run"
  ( cd "$d" && bash ./run_benchmark.sh "$@" ) 2>&1 | tee -a "$logf"; [ "${PIPESTATUS[0]}" -eq 0 ] || return 1
  echo ">> log: $logf"
}
case "${1:-}" in
  list)
    git config -f .gitmodules --get-regexp '^submodule\..*\.path$' | while read -r key p; do
      name=$(basename "$p")
      state="not fetched"; [ -e "$p/.git" ] && state="ready"
      printf '%-4s %-60s %s\n' "${name%%-*}" "$name" "$state"
    done ;;
  all)
    pass=0; fail=0; failed=()
    for d in [1-4][0-9][0-9]-*/; do
      n=$(basename "$d"); n=${n%%-*}
      if run_one "$n"; then pass=$((pass+1)); else fail=$((fail+1)); failed+=("$n"); fi
    done
    echo "== $pass passed, $fail failed ${failed[*]:-}" ;;
  ''|-h|--help) sed -n '2,3p' "$0" | sed 's/^# //' ;;
  *) n=$1; shift; run_one "$n" "$@" ;;
esac
