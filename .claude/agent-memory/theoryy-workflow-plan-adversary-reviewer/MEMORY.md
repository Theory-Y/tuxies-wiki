# Memory index

- [Deploy trigger & publish gates](deploy-trigger-and-publish-gates.md) — push-triggered Cloudflare deploy; "don't publish until X" gates are really push-time gates (SPOF)
- [Render check is not correctness](render-check-is-not-correctness.md) — recurring weak spot: `npm run build` proves PARSE only, never content correctness; demand a separate correctness check
