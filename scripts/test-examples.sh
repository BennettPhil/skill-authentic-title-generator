#!/usr/bin/env bash
set -euo pipefail

PASS=0
FAIL=0

expect_eq() {
  local got="$1"
  local expected="$2"
  local label="$3"
  if [ "$got" = "$expected" ]; then
    PASS=$((PASS + 1))
  else
    FAIL=$((FAIL + 1))
    echo "FAIL: $label"
    echo "Expected:"
    printf '%s\n' "$expected"
    echo "Got:"
    printf '%s\n' "$got"
  fi
}

out1="$(./scripts/run.sh --input "remote onboarding for distributed engineering teams" --count 3)"
expect_eq "$out1" $'1. Why remote onboarding for distributed engineering teams deserves a closer look\n2. remote onboarding for distributed engineering teams: practical strategies that actually work\n3. What teams get wrong about remote onboarding for distributed engineering teams' "basic example"

out2="$(echo "pricing transparency in B2B SaaS" | ./scripts/run.sh --count 2)"
expect_eq "$out2" $'1. Why pricing transparency in B2B SaaS deserves a closer look\n2. pricing transparency in B2B SaaS: practical strategies that actually work' "stdin pattern"

out3="$(./scripts/run.sh --input "developer productivity in legacy monoliths" --tone playful --count 2)"
expect_eq "$out3" $'1. developer productivity in legacy monoliths without the buzzword bingo\n2. Can developer productivity in legacy monoliths be simple? here is how' "playful pattern"

out4="$(./scripts/run.sh --input "incident review templates for platform teams" --count 2 --format json)"
expect_eq "$out4" '{"titles":["Why incident review templates for platform teams deserves a closer look","incident review templates for platform teams: practical strategies that actually work"]}' "json pattern"

out5="$(TITLEGEN_PREFIX="[Draft] " ./scripts/run.sh --input "change management for internal tooling migrations" --count 2)"
expect_eq "$out5" $'1. [Draft] Why change management for internal tooling migrations deserves a closer look\n2. [Draft] change management for internal tooling migrations: practical strategies that actually work' "prefix pattern"

set +e
./scripts/run.sh --input "   " >/tmp/titlegen_empty.out 2>&1
rc=$?
set -e
if [ "$rc" -ne 0 ] && grep -q "Error: idea text cannot be empty" /tmp/titlegen_empty.out; then
  PASS=$((PASS + 1))
else
  FAIL=$((FAIL + 1))
  echo "FAIL: empty input edge case"
fi

echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
