---
name: quantum-ai-exposure-triage
description: "Use when a system looks cryptographically compliant on paper (PQC deployed, valid signatures, clean vulnerability scan) but someone wants to know what's still invisible to that scan — e.g. \"we have PQC deployed, are we still leaking through timing, telemetry, or side channels?\", \"our AI infra looks compliant, what would a conventional audit miss?\", \"is this anomaly noise, a bug, a side-channel signal, or an active threat?\", or before approving an AI/quantum-security system for production. Correlates cryptographic posture with behavioral trust telemetry (STG) and execution/side-channel telemetry (QSP) into a single scored Exposure Decision Brief: a 0–100 score decomposed into three dimensions, ranked findings with evidence and confidence, and a Go / Investigate / Contain / Block call — plus what a conventional audit would have missed. Not a PQC compliance checklist or a vulnerability scanner; use a standard audit/scan skill when the question is only \"are we compliant,\" and use this one when the question is \"what would compliance miss.\""
metadata:
  status: sandbox-proposed
  author: vijay@vyaptiresonance.com
---

# Quantum × AI Exposure Triage

Correlates three independently-measured surfaces — cryptographic posture, behavioral trust (STG), and execution/side-channel telemetry (QSP) — to find compromises that are invisible to a compliance scan because they don't live in any single layer. Produces a scored, evidence-backed Exposure Decision Brief with an operational call: Continue, Investigate, Contain, or Block.

## What it does

A conventional audit answers "is this system compliant?" — valid signature, valid cert, PQC algorithms present, scan clean. This skill answers a different question: **given that it's compliant, what could still be exploitable, and how would we know?**

It does this by refusing to let any one layer vouch for the others:

- **Cryptographic posture** (algorithms, key lifecycle, harvest-now-decrypt-later exposure) is necessary but not sufficient.
- **STG (Sentient TrustGraph)** — behavioral trust across users, services, AI agents, APIs, and infrastructure, including interaction kinematics (typing cadence, mouse movement, click sequences) as a probabilistic identity signal on top of credentials.
- **QSP (Quantum Security Probe)** — non-intrusive execution and telemetry measurement (timing, resource utilization, execution behavior) against a calibrated baseline, without inspecting packet contents.

None of the three is trusted alone. The finding that matters is the **cross-layer discontinuity**: the same valid identity, signed artifact, or expected service relationship, but its execution behavior, interaction pattern, or human/device signature has materially changed. Full definitions and the non-intrusive-telemetry architectural principle are in [references/definitions.md](references/definitions.md).

## When NOT to use

- The question is only "are we PQC/compliance compliant" — that's a standard audit skill, not this one.
- There's no baseline (no established normal execution/behavioral profile to deviate from) — run this only after a calibration period, or explicitly flag every finding as low-confidence for lack of baseline.
- You're being asked to attribute an incident to a specific actor or vendor. This skill scores exposure and recommends containment; it explicitly does not declare attribution (see Common Mistakes #15).

## The judgment model

Every finding in the brief must move through all six stages — skipping straight to a score or a verdict is the failure mode this skill exists to prevent:

1. **Observation** — what was actually measured?
2. **Interpretation** — what does that mean operationally?
3. **Hypothesis** — what security explanation could account for it?
4. **Evidence** — what supports it, what contradicts it, what benign explanation hasn't been ruled out?
5. **Confidence** — how strongly does available evidence support the hypothesis, stated explicitly (not implied by the score alone)?
6. **Decision** — what should the operator do right now?

A score, a "3 anomalies detected," or a Contain/Block call presented without this chain behind it is not this skill's output — it's the mediocre version the graduation bar exists to reject.

## The 30-second tell

Open every investigation by separating **trust** from **behavior**. Valid credentials, a valid signature, and an approved endpoint are evidence of authorization and provenance — not proof of benign behavior. Immediately ask:

- Does the component/user/agent behave as expected, or has its execution profile changed?
- Has its interaction graph (who it talks to, in what sequence) changed?
- Has the human input signature changed for this identity?
- Did multiple signals change together, and did the change start right after a deployment, dependency, config, or identity change?
- Is the deviation reproducible? Is there a plausible benign explanation? Does it sit on a meaningful attack path (e.g. identity provider → privileged AI agent → production database)?

If the answer to "trust checks out, but behavior changed" is yes, that's the finding — not "CPU went up."

## Scoring

Three independently reported 0–100 dimensions, combined into an Initial Exposure Priority Score:

| Dimension | Weight |
|---|---|
| Cryptographic Exposure | 20% |
| Behavioral Trust Deviation (STG) | 40% |
| Execution / Side-Channel Anomaly (QSP) | 40% |

These weights are calibration defaults, not constants — recalibrate against real QSP/STG history. **A single anomalous measurement never produces a high-confidence compromise classification on its own** — every finding must independently carry severity, evidence confidence, and attack-path relevance. Evidence progresses through four states (Insufficient Evidence → Anomalous → Suspected Exposure → Corroborated Exposure) before a finding earns the "corroborated" label. Full state definitions and worked scoring are in [references/scoring-rubric.md](references/scoring-rubric.md).

Default operational thresholds:

| Score | Call |
|---|---|
| 0–39 | CONTINUE / Monitor |
| 40–74 | INVESTIGATE |
| 75–89 | CONTAIN / Escalate |
| 90–100 | BLOCK / Emergency response |

These are decision-support defaults, not proof thresholds — a critical attack path (e.g. touching an identity provider or a privileged AI action) can justify containment below the default score, and that override must be stated explicitly in the brief, not applied silently.

## Playbook branches

Route every investigation through the branch that matches what actually corroborates:

- **A — Crypto-weak, behavior clean.** Weak/outdated/quantum-exposed crypto, but STG and QSP both sit inside baseline → architectural/crypto-debt exposure, not active compromise. Assess harvest-now-decrypt-later exposure, prioritize PQC migration, don't interrupt production for this alone.
- **B — Behavioral deviation, no execution corroboration.** Crypto acceptable, STG flags a real anomaly, QSP finds nothing → suspected trust abuse. Investigate credential/token misuse, privilege escalation, human/device mismatch, and legitimate operational explanations before escalating.
- **C — Correlated behavioral + execution anomaly, same window.** STG and QSP both fire independently, in the same transaction/process/time window, against a reliable baseline, with benign explanations investigated → confidence rises substantially. This is the branch that justifies containment.
- **D — Valid signature, deviant behavior.** Signature, provenance, and conventional controls all check out, but behavior deviates from baseline anyway → the signature is not exculpatory. Treat provenance and behavioral integrity as separate evidence dimensions and investigate the gap.
- **E — AI automation with a human-control boundary.** Routine AI-agent actions continue automating; a specific action is designated high-risk/irreversible/privileged → gate that action on STG identity, behavioral, and kinematic signals matching the expected authorized human before allowing it.
- **F — Human/device behavioral mismatch, valid auth.** Identity and authorization both check out, but interaction kinematics don't match the established baseline → treat as an added risk signal, not automatic compromise. Check for maintenance, shared devices, delegation, accessibility factors — then raise verification requirements for high-risk actions if the mismatch stands.

Full IF/THEN branch logic (including what to name as the specific investigative next step per branch) is in [references/playbook-branches.md](references/playbook-branches.md). A complete worked example — a validly-signed vendor update that triggers Branch C — is in [references/worked-example.md](references/worked-example.md).

## Common mistakes

The load-bearing ones (full list of fifteen, including baseline-quality and network/execution-conflation traps, in [references/common-mistakes.md](references/common-mistakes.md)):

1. **Signed = safe.** A valid signature is evidence of authenticity, not proof of benign behavior.
2. **Authenticated = authorized for everything; authorized = behaviorally trusted.** Each is a separate gate, not a chain that transfers trust downward.
3. **Anomaly = attack.** An anomaly means "differs from baseline." It does not establish why. Don't let the brief collapse that gap.
4. **One measurement becomes the verdict.** Timing, CPU, cache behavior, or kinematics alone almost always have a benign explanation — they're inputs to correlation, not verdicts.
5. **Producing a score without the evidence trail.** A number without Observation → Interpretation → Hypothesis → Evidence → Confidence behind it is not operator judgment; it's noise with a decimal point.
6. **Declaring attribution too early.** Detecting suspicious behavior does not establish which vendor, component, or actor caused it — say so explicitly rather than naming a culprit the evidence doesn't support yet.

## What good looks like

**Mediocre:** "Three anomalies detected. Risk score: 78. Investigate."

**Strong:** "The observed behavior differs from baseline in three dimensions. Two are independently corroborated. The deviation began immediately after deployment and affects a privileged interaction path. A legitimate configuration change remains a plausible alternative explanation and has not yet been eliminated. We therefore recommend containment and controlled investigation rather than declaring compromise."

An excellent Decision Brief answers all ten of: what changed, why it matters, what evidence supports it, what evidence contradicts it, what benign explanations exist, what evidence would distinguish those explanations, the potential attack path, confidence level, what the operator should do immediately, and — explicitly — what should *not* be concluded yet.

Every brief this skill produces should close with a **"what a conventional audit would have missed"** line — that's the deliverable's reason to exist. Never manufacture precision: thresholds, weights, and confidence levels are decision-support defaults to be recalibrated against real QSP/STG history and incidents, not universal constants, and the brief should say so when they're still uncalibrated for the system in question.

## Gotchas

Not yet run 5+ times in real work — this is a sandbox proposal, not a graduated skill. Anticipated failure modes to watch for and replace with observed ones after real runs:

- Letting a single strong QSP or STG signal jump straight to "Corroborated Exposure" without the independent second signal Branch C requires.
- Treating the 20/40/40 weighting as calibrated for a given environment on first use — it isn't, until run against that system's real incident history.
- Naming a vendor, component, or attacker in the Decision section when the evidence only supports "behavior deviated" (see Common Mistake #15/attribution).
- Producing a score and threshold call without the Observation→...→Decision chain for at least the top finding — the fastest way this skill degrades into exactly the checklist the graduation bar rejects.
