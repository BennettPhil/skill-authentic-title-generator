# Advanced Usage

## 1) Add a workflow prefix

Use this when generating draft title candidates for review queues.

```bash
TITLEGEN_PREFIX="[Draft] " ./scripts/run.sh --input "change management for internal tooling migrations" --count 2
```

Expected output:

```text
1. [Draft] Why change management for internal tooling migrations deserves a closer look
2. [Draft] change management for internal tooling migrations: practical strategies that actually work
```

## 2) Generate a larger set as JSON

```bash
./scripts/run.sh --input "scaling support operations in product-led SaaS" --count 5 --format json
```

Expected output:

```json
{"titles":["Why scaling support operations in product-led SaaS deserves a closer look","scaling support operations in product-led SaaS: practical strategies that actually work","What teams get wrong about scaling support operations in product-led SaaS","How to make scaling support operations in product-led SaaS easier to apply","scaling support operations in product-led SaaS explained in plain language"]}
```
