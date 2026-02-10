#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./scripts/run.sh [--input "<idea>"] [--count N] [--tone standard|playful] [--format text|json] [--strict-authentic]

Input can be passed with --input or piped via stdin.
EOF
}

trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "$s"
}

die() {
  printf 'Error: %s\n' "$1" >&2
  exit "${2:-1}"
}

idea=""
count=5
tone="standard"
format="text"
strict_authentic=false
max_input="${TITLEGEN_MAX_INPUT:-500}"
prefix="${TITLEGEN_PREFIX:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --input)
      shift
      idea="${1:-}"
      ;;
    --count)
      shift
      count="${1:-}"
      ;;
    --tone)
      shift
      tone="${1:-}"
      ;;
    --format)
      shift
      format="${1:-}"
      ;;
    --strict-authentic)
      strict_authentic=true
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      die "unknown option $1"
      ;;
  esac
  shift || true
done

if [[ -z "$idea" ]]; then
  if [ ! -t 0 ]; then
    idea="$(cat)"
  fi
fi

idea="$(trim "$idea")"
[ -n "$idea" ] || die "idea text cannot be empty" 2

if ! [[ "$count" =~ ^[0-9]+$ ]] || [ "$count" -lt 1 ] || [ "$count" -gt 20 ]; then
  die "--count must be an integer between 1 and 20" 2
fi

if [ "${#idea}" -gt "$max_input" ]; then
  die "input exceeds maximum length ($max_input)" 2
fi

if [ "$tone" != "standard" ] && [ "$tone" != "playful" ]; then
  die "--tone must be standard or playful" 2
fi

if [ "$format" != "text" ] && [ "$format" != "json" ]; then
  die "--format must be text or json" 2
fi

declare -a titles
if [ "$tone" = "standard" ]; then
  titles+=("Why $idea deserves a closer look")
  titles+=("$idea: practical strategies that actually work")
  titles+=("What teams get wrong about $idea")
  titles+=("How to make $idea easier to apply")
  titles+=("$idea explained in plain language")
  titles+=("The implementation guide to $idea")
else
  titles+=("$idea without the buzzword bingo")
  titles+=("Can $idea be simple? here is how")
  titles+=("$idea, but practical")
  titles+=("No hype: $idea that teams can actually use")
  titles+=("$idea for people who want real outcomes")
fi

if [ "$strict_authentic" = true ]; then
  for i in "${!titles[@]}"; do
    t="${titles[$i]}"
    t="${t//shocking/clear}"
    t="${t//unbelievable/credible}"
    t="${t//mind-blowing/useful}"
    titles[$i]="$t"
  done
fi

limit=$count
[ "$limit" -gt "${#titles[@]}" ] && limit="${#titles[@]}"

declare -a out
for ((i=0; i<limit; i++)); do
  out+=("$prefix${titles[$i]}")
done

if [ "$format" = "json" ]; then
  printf '%s\n' "${out[@]}" | jq -Rsc 'split("\n")[:-1] | {titles:.}'
  exit 0
fi

for ((i=0; i<limit; i++)); do
  n=$((i+1))
  printf '%d. %s\n' "$n" "${out[$i]}"
done
