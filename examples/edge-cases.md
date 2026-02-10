# Edge Cases

## Empty input

```bash
./scripts/run.sh --input "   "
```

Expected output:

```text
Error: idea text cannot be empty
```

## Invalid count value

```bash
./scripts/run.sh --input "retention strategies for marketplace founders" --count 0
```

Expected output:

```text
Error: --count must be an integer between 1 and 20
```

## Extremely large input

```bash
python - <<'PY'
print("x" * 600)
PY
```

Then pipe it:

```bash
python - <<'PY' | ./scripts/run.sh
print("x" * 600)
PY
```

Expected output:

```text
Error: input exceeds maximum length (500)
```
