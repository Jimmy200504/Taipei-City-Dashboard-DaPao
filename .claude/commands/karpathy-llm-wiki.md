---
description: Karpathy-style personal LLM wiki — ingest a source, query the wiki, or lint it
argument-hint: [ingest <url|topic> | query <question> | lint]
---

Operate the karpathy-llm-wiki skill. Before doing anything, read `.agents/skills/karpathy-llm-wiki/SKILL.md` in full, and consult the templates in `.agents/skills/karpathy-llm-wiki/references/` when you need exact formats.

The skill defines three operations:
- **Ingest** — fetch a source into `raw/` and compile into `wiki/`
- **Query** — search the wiki and answer a question (optionally archive the answer)
- **Lint** — run quality checks on the wiki

User request: $ARGUMENTS

If `$ARGUMENTS` is empty, ask the user which operation they want and what input to use. Otherwise, infer the operation from the request and follow the SKILL.md workflow exactly.