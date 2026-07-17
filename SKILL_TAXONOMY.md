# Skill Taxonomy

The 82 skills in this repo mapped to the 9 categories from [Anthropic's Skills guide](https://medium.com/@tortmario/skills-for-claude-code-the-ultimate-guide-from-an-anthropic-engineer).

The guide's insight: **skills that blur multiple categories confuse both Claude and users**. Use this map to:
- Find the right skill for a job
- Spot overlapping/duplicate skills that should be consolidated
- Decide where a new skill belongs

## 1. Library & API References (43 skills)

Explains how to use a library, CLI, or SDK correctly. Most of this repo — these are the biggest category by far.

**Railway (13):** `railway-new`, `railway-deploy`, `railway-deployment`, `railway-status`, `railway-service`, `railway-environment`, `railway-database`, `railway-domain`, `railway-templates`, `railway-projects`, `railway-metrics`, `railway-central-station`, `railway-railway-docs`

**Vercel (6):** `deploy-to-vercel`, `vercel-cli-with-tokens`, `vercel-react-best-practices`, `vercel-composition-patterns`, `vercel-react-native-skills`, `web-design-guidelines`

**HuggingFace (11):** `hf-cli`, `huggingface-llm-trainer`, `huggingface-vision-trainer`, `huggingface-community-evals`, `huggingface-datasets`, `huggingface-gradio`, `huggingface-papers`, `huggingface-paper-publisher`, `huggingface-tool-builder`, `huggingface-trackio`, `transformers-js`

**Obsidian (5):** `obsidian-cli`, `obsidian-markdown`, `obsidian-bases`, `json-canvas`, `defuddle`

**Efecto (3):** `efecto-web-design`, `efecto-graphic-design`, `efecto-social-media`

**Design frameworks (5):** `ui-ux-pro-max`, `interface-craft`, `emil-design-eng`, `design-taste-frontend`, `stitch-design-taste`

## 2. Product Verification (1 skill)

Describes how to test and verify code behavior.

- `evidence-driven-testing` — records annotated screen-recording proof of UI behavior (structured test/assertion annotations) and posts the video + results summary to the PR and tracker issue. In the M6 Product pack.

Candidates still to build:
- A `lighthouse-audit` skill that runs Lighthouse CI with assertions
- A `portco-demo-driver` that drives a portfolio company's app with Playwright
- A `screenshot-diff` skill for visual regression testing

## 3. Data Retrieval & Analysis (0 skills)

Connects to data and monitoring stacks. **Gap in this repo.** Candidates:
- A skill that queries your Utopia portco database
- A deal-flow analysis skill
- Grafana / PostHog / Linear integration skills

## 4. Business Process & Team Automation (3 skills)

Automates repetitive workflows.

- `pitch-deck` — generate Utopia-branded decks from notes
- `technical-dd` — generate investment-grade TDD reports
- `kmjp-social` — personal (not in team packs), generates social posts

## 5. Code Templates & Scaffolding (0 skills)

Generates framework boilerplate. **Gap.** Candidates:
- `new-portco-repo` — scaffolds a repo with Utopia conventions
- `new-dd-report` — scaffolds a TDD doc from template

## 6. Code Quality & Code Review (17 skills)

Enforces quality standards and assists reviews. Lots of overlap here — could be consolidated.

**Design critique & polish:** `critique`, `audit`, `polish`, `redesign-existing-projects`, `high-end-visual-design`, `industrial-brutalist-ui`, `minimalist-ui`

**Design enhancement:** `shape`, `layout`, `typeset`, `colorize`, `animate`, `adapt`, `optimize`, `clarify`, `distill`, `delight`

⚠️ **Potential duplicates to review:** `audit` and `polish` overlap significantly. `design-taste-frontend` and `high-end-visual-design` make similar claims. Worth consolidating.

## 7. CI/CD & Deployment (6 skills)

Ships code.

- `deployment-engineer` — CI/CD setup
- `integration-linker` — connects Slack/GitHub/Linear
- `monitoring-setup` — Sentry, PostHog, health checks
- `prompt-engineer` — makes repo AI-native
- `repo-structurer` — cleans up repo structure
- `repo-scanner` — audits production readiness

## 8. Runbooks (0 skills)

Takes a symptom, investigates, produces a report. **Gap.** Candidates:
- `portco-debug` — investigates why a portco app is down
- `deployment-triage` — maps error symptoms to fixes

## 9. Infrastructure Operations (3 skills)

Routine maintenance and ops.

- `cost-optimizer` — identifies unused cloud resources
- `devops-advisor` — database config, caching, scaling audit
- `security-auditor` — secret scanning, dep vulnerabilities

## Specialty / Amplifiers (7 skills)

Skills that don't fit the 9 categories cleanly — they modify Claude's behavior rather than providing information about external systems.

- `impeccable` — master skill that orchestrates design sub-skills (shape → build → critique)
- `bolder`, `quieter`, `overdrive` — amplitude dials for design output
- `full-output-enforcement` — overrides LLM truncation behavior
- `sketch-prompt` — generates sketch images via Flux
- `architecture-diagram`, `diagram-design` — generate standalone HTML diagrams

## Meta (2 skills)

- `skillshare` — manages sync across AI tools
- `find-skills` — discover and install skills

## Key Observations

**Strengths:** Heavy coverage of Library & API References (deployment, ML, design frameworks) and Code Quality. This repo gives Claude a very opinionated design pipeline.

**Gaps to consider filling:**
1. **Verification** — no skill tests that Claude's output actually works. Huge value unlock for team usage.
2. **Data retrieval** — no way for Claude to pull portco metrics, deal data, or monitoring. Would make DD much stronger.
3. **Runbooks** — no symptom-to-investigation patterns.

**Overlaps to consider consolidating:**
- Design critique skills (`critique`, `audit`, `polish`) — overlap significantly
- Visual style skills (`industrial-brutalist-ui`, `minimalist-ui`, `high-end-visual-design`, `design-taste-frontend`) — similar promises

See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for how to propose new skills or consolidate existing ones.
