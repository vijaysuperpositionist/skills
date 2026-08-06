# Skill Taxonomy

All skills in this repo map to **four modules**. Skills that blur modules confuse both Claude and users — pick one.

| Module | Folder | Pack | Count | Put here when… |
|--------|--------|------|------|----------------|
| **GTM** | `skills/gtm/` | `utopia-gtm` | 83 | Sales, marketing, growth, retention, distribution |
| **Product** | `skills/product/` | `utopia-product` | 128 | Discovery, PRDs, design, build, deploy, product metrics |
| **Investments** | `skills/investments/` | `utopia-investments` | 60 | DD, modeling, valuation, fundraising, markets, quant |
| **Founder Productivity** | `skills/founder-productivity/` | `utopia-founder-productivity` | 30 | Doesn't fit the three above |

**Total: 301 skills** (plus `skills/sandbox/` for experiments).

## GTM

Positioning, ICP, outbound, content, paid, partnerships, retention/expansion plays, CRO, brand narrative.

Examples: `gtm-strategy`, `cold-email`, `positioning-icp`, `growth-loops`, `churn-prevention`, `copywriting`.

## Product

Discovery → concept → design → build → deploy → measure.

Examples: `jobs-to-be-done`, `create-prd`, `impeccable`, `railway-deploy`, `deploy-to-vercel`, `evidence-driven-testing`, `north-star-metric`.

## Investments

Funds work and fundraising: technical DD, IB modeling, capital markets, decks, quant pricing, IP diligence.

Examples: `technical-dd`, `pitch-deck`, `dcf-model`, `comps-analysis`, `bayesian-reasoning-calibration`, `ada`, `khalil`.

Also includes `pitch-deck-web` (interactive deck site builder) alongside `pitch-deck` (PPTX).

## Founder Productivity

Catch-all for operator tools that aren't GTM, Product, or Investments:

- Onboarding frameworks (TAM/SAM/SOM, SWOT, stakeholder maps)
- Legal / hiring docs (NDA, privacy policy, resume)
- Knowledge management (Obsidian, Proof, last30days)
- Agents & meta (`salim`, `agent-prd`, `agent-persona-builder`, `find-skills`)

## Decision rule

```
Sales / growth / distribution?     → GTM
Building or designing the product? → Product
Capital, DD, or fundraising?       → Investments
None of the above?                 → Founder Productivity
```

See [`packs.config.json`](./packs.config.json) for the exact skill list in each pack.
