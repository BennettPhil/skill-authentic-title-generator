# Common Patterns

## 1) Pipe idea text through stdin

When the idea comes from another command or file.

```bash
echo "pricing transparency in B2B SaaS" | ./scripts/run.sh --count 2
```

Expected output:

```text
1. Why pricing transparency in B2B SaaS deserves a closer look
2. pricing transparency in B2B SaaS: practical strategies that actually work
```

## 2) Use playful tone while staying authentic

When the audience tolerates a lighter headline style.

```bash
./scripts/run.sh --input "developer productivity in legacy monoliths" --tone playful --count 2
```

Expected output:

```text
1. developer productivity in legacy monoliths without the buzzword bingo
2. Can developer productivity in legacy monoliths be simple? here is how
```

## 3) Return JSON for automation

When the output feeds another script.

```bash
./scripts/run.sh --input "incident review templates for platform teams" --count 2 --format json
```

Expected output:

```json
{"titles":["Why incident review templates for platform teams deserves a closer look","incident review templates for platform teams: practical strategies that actually work"]}
```
