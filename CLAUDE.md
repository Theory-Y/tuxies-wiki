## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:

- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).

## Output guideline

The guideline for the output is put in /docs/notes/about/contributions/guidelines.md, follow it for consistency.

**Any agent (main or subagent) MUST read `/docs/notes/about/contributions/guidelines.md` before editing docs content.** When delegating a docs edit to a subagent, instruct it to read the guidelines first — cover at minimum the entry order (link → `:::info` → `:::tip` → image last), the colon-nesting rule (outer container has more colons than any container nested inside), and the icon hierarchy (tabs prefer `devicon`).
