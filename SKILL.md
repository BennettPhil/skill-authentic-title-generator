---
name: authentic-title-generator
description: Generate clickable but credible content titles from an idea without hype language.
version: 0.1.0
license: Apache-2.0
---

# Authentic Title Generator

## Purpose

Generate multiple high-interest title options from an article idea while keeping the language
honest, specific, and non-clickbaity.

## See It in Action

Start with `examples/basic-example.md`.

## Examples Index

- `examples/basic-example.md`: First run with minimal flags.
- `examples/common-patterns.md`: Typical workflows: stdin input, playful tone, JSON output.
- `examples/advanced-usage.md`: Prefix customization and larger output sets.
- `examples/edge-cases.md`: Empty input, invalid count, and oversized input handling.

## Reference

- Command: `./scripts/run.sh`
- Inputs: `--input "<idea>"` or stdin
- Flags: `--count`, `--tone`, `--format`, `--strict-authentic`
- Env vars: `TITLEGEN_PREFIX`, `TITLEGEN_MAX_INPUT`

## Installation

```bash
chmod +x ./scripts/run.sh ./scripts/test-examples.sh
```
