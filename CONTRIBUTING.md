# Contributing

How to propose, share, and graduate skills in this marketplace.

## The Sandbox → Pack Flow

Based on the pattern Anthropic's Claude Code team uses internally. The goal: let anyone propose skills without overloading the default packs that every team member loads.

```
   idea
    │
    ▼
 sandbox/          ← experimental, anyone can add here, PR review light
    │
    ▼  (battle-tested, actually used, consistent quality)
    │
 skills/<module>/     ← official source of truth (gtm|product|investments|founder-productivity)
    │
    ▼
 packs.config.json ← added to a pack so team installs it
```

## Proposing a New Skill

**1. Create it in `skills/sandbox/<skill-name>/`**

Minimum structure:

```
skills/sandbox/my-skill/
└── SKILL.md
```

`SKILL.md` frontmatter:

```markdown
---
name: my-skill
description: One sentence. Written AS CONDITIONS FOR WHEN TO TRIGGER, not as a summary. E.g. "Use when the user asks to build X, mentions Y, or needs Z."
---

# My Skill

## What it does
...

## Gotchas
- Real mistakes Claude makes when using this skill (update as you find them)

## Examples
...
```

**2. Test it**

Use it in real work for a few days. Record every time Claude misunderstands or goes off-track — those go into the Gotchas section.

**3. Share**

Open a PR, or post a link to the branch in Slack / the team forum. Get at least one other person to try it.

## Graduating a Skill

A skill is ready to graduate when it meets all of these:

- [ ] You (or someone else) has used it 5+ times in real work
- [ ] Gotchas section exists and reflects real edge cases
- [ ] Description is written as **trigger conditions**, not a summary
- [ ] Doesn't duplicate an existing skill (check by category first)
- [ ] Has at least one concrete example

**To graduate:**

1. Move `skills/sandbox/<skill>/` → `skills/<module>/<skill>/` (one of: `gtm`, `product`, `investments`, `founder-productivity`)
2. Add the skill name to that module's pack in `packs.config.json`
3. Run `./build-packs.sh`
4. Open a PR explaining: what problem it solves, who asked for it, gotchas found so far

## Modules

Skills live in one of four modules. When proposing, pick the best fit:

1. **GTM** (`skills/gtm/`) — sales, marketing, growth, retention, distribution
2. **Product** (`skills/product/`) — discovery, design, build, deploy, product metrics
3. **Investments** (`skills/investments/`) — DD, finance, fundraising, markets, quant
4. **Founder Productivity** (`skills/founder-productivity/`) — everything else (onboarding, legal, knowledge tools, agents)

If a skill blurs modules, put it in Founder Productivity rather than duplicating. See [SKILL_TAXONOMY.md](./SKILL_TAXONOMY.md).

## Curation Principles

When reviewing a proposal:

- **Don't write the obvious** — Claude already knows basic coding. The skill should push past defaults.
- **Leave flexibility** — overly specific instructions backfire. Give Claude what it needs, let it adapt.
- **Prefer scripts over prose** — if a skill can ship a script that does the work deterministically, it should.
- **Kill duplicates** — if a new skill overlaps with existing one, either merge or reject.

## Writing Good Descriptions

The `description` field in SKILL.md is the **only thing Claude sees when deciding whether to use the skill**. It's a trigger condition, not a summary.

**Bad:** `"A skill for generating diagrams"`
**Good:** `"Use when the user asks for architecture diagrams, flowcharts, sequence diagrams, or ER diagrams. Output is standalone HTML + inline SVG."`

Good descriptions include:
- Concrete trigger phrases the user might say
- What the output looks like
- When NOT to use it (if it overlaps with a similar skill)

## Questions?

Ask Karan (@kmjp) or open an issue.
