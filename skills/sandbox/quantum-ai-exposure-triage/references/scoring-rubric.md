# Scoring rubric

## Three dimensions, independently reported

- **Cryptographic Exposure** — 0–100
- **Behavioral Trust Deviation (STG)** — 0–100
- **Execution / Side-Channel Anomaly (QSP)** — 0–100

Report all three separately in the brief — never collapse straight to the composite. A reader needs to see which dimension is actually driving the score.

## Initial Exposure Priority Score

Weighted combination, calibration defaults:

- Cryptographic Exposure — 20%
- Behavioral Trust Deviation — 40%
- Execution / Side-Channel Anomaly — 40%

These are initial calibration parameters, not universal security constants. Recalibrate against real QSP/STG observations and historical incidents for the specific environment — state in the brief when weights are still using un-recalibrated defaults.

**Hard rule:** do not allow a single anomalous measurement to automatically produce a high-confidence compromise classification, regardless of how high that one measurement scores.

## Evidence state ladder

Every significant finding progresses through these states — name the state explicitly in the brief, don't just imply it from the score:

1. **Insufficient Evidence** — not enough trustworthy evidence to establish that the deviation is meaningful.
2. **Anomalous** — a meaningful deviation from baseline has been observed, but the cause is unresolved.
3. **Suspected Exposure** — multiple relevant observations support a plausible security-compromise hypothesis, but credible alternative (benign) explanations remain.
4. **Corroborated Exposure** — independent or causally related evidence substantially supports the hypothesis, and competing benign explanations have been sufficiently investigated to justify an operational response.

A finding should not be labeled "Corroborated" on the strength of one signal, even a strong one — corroboration requires an independent second signal (see Playbook Branch C) or investigation that has actively ruled out the plausible benign alternatives.

## Every significant finding carries three attributes

- **Severity** — how bad if true
- **Evidence confidence** — how sure we are it's true
- **Attack-path relevance** — how much it matters given what it touches (e.g. identity provider → privileged AI agent → production database scores very differently than the same anomaly on an isolated, non-privileged service)

## Operational thresholds (defaults)

| Score | Call |
|---|---|
| 0–39 | CONTINUE / Monitor |
| 40–74 | INVESTIGATE |
| 75–89 | CONTAIN / Escalate |
| 90–100 | BLOCK / Emergency response |

These are decision-support defaults, not proof thresholds. A critical attack path can justify containment even when the numerical score sits below the default threshold — when that override is used, state it explicitly in the Decision section rather than quietly bumping the number to match.

## The one inviolable rule

A score must never be presented without the evidence and reasoning that produced it. If you can't fill in Observation → Interpretation → Hypothesis → Evidence → Confidence for a finding, that finding doesn't get a severity/confidence rating yet — it stays at Insufficient Evidence.
