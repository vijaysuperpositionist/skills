# Scoring rubric

**Everything in this file is a provisional calibration default, not a scientifically validated threshold.** These numbers exist to give a consistent starting structure — recalibrate them against real QSP history for the specific environment before relying on them operationally. Say so explicitly whenever a score is presented against uncalibrated defaults.

## Why gates-then-factors, not a weighted composite

An earlier version of this skill scored a fixed weighted composite across three dissimilar dimensions (cryptographic posture, a separate behavioral-trust product, and QSP). That structurally capped QSP's contribution to roughly 40-44 points out of 100 regardless of how strong its own evidence was, because it was competing for a fixed share of weight against dimensions outside its control. This skill is QSP-only — there is nothing else to weight against — so the scoring model is a single product's own evidence strength, gated before it can be scored, not summed against unrelated axes.

## Gates

Must **all** pass before any finding can be scored above Insufficient Evidence:

1. **Reliable baseline exists** for this signal category, in this context (workload, deployment version, time-of-day/seasonality, environment). A baseline collected under one workload or environment may not generalize to another — verify it applies to the context being evaluated, don't assume it does.
2. **Deviation is reproducible** — confirmed under replay or repeated observation, not a single unexplained blip.
3. **The most plausible benign causes have been checked** — see [false-positive-handling.md](false-positive-handling.md). Not assumed absent; actually checked.

A finding that fails any gate stays at Insufficient Evidence no matter how dramatic the raw deviation looks.

## Factors (scored only once gated)

| Factor | Points | Basis |
|---|---|---|
| Corroboration breadth | 0–40 | 1 signal category = 10; 2 independent categories, same trigger/window = 25; 3+ independent categories = 40 |
| Magnitude | 0–30 | Per signal type. Timing/resource: <2x baseline = 5, 2–10x = 15, >10x = 30. Network/egress: contact with a novel, undocumented endpoint = 20, +10 if the traffic shows entropy or DGA-like patterns. Process/system-behavior and cryptographic-operation-behavior: score by analogy to the closest applicable band above — not yet independently calibrated (see Gotchas). |
| Trigger specificity & trajectory | 0–30 | Diffuse and stable = 5; narrow/specific trigger, stable volume = 15; narrow/specific trigger and growing/spreading over time = 30 |

**Total: 0–100.**

Note the deliberate asymmetry: a narrow, trigger-specific deviation scores *higher* than a diffuse, environment-wide one at the same magnitude. This is intentional — a condition-gated deviation is more consistent with deliberately introduced logic than organic variance, which tends to be diffuse. Don't let a large diffuse number outscore a small but precisely-triggered one without checking which pattern the evidence actually shows.

## Evidence ladder

| State | Criteria |
|---|---|
| Insufficient Evidence | No reliable baseline, or a single unreplicated observation |
| Anomalous (Unconfirmed) | Reproducible deviation from a reliable baseline, one signal category, benign causes not yet fully checked |
| Anomalous (Corroborated) | Reproducible deviation confirmed across ≥2 independent signal categories on the same trigger/window, **or** one category with benign causes actively checked and ruled out |
| Confirmed Execution-Compromise Indicator | Multiple independent signal categories deviate together, causally tied to an identifiable trigger or change, benign causes ruled out, pattern inconsistent with the component's documented/intended function |

Named "Indicator" deliberately: the top rung confirms the *evidence*, not that a compromise occurred. QSP characterizes; it does not verdict.

## Decision thresholds

| Score | QSP recommends |
|---|---|
| 0–24 | Monitor |
| 25–49 | Flag for review |
| 50–74 | Escalate for investigation |
| 75–100 | Escalate — containment recommended |

These are recommendations for a downstream decision-maker or process, not an order QSP issues on its own authority.

## Overrides

Named, explicit, and must be stated in the brief whenever applied — never a silent score bump:

- **Trajectory override (Branch Q5):** the deviation's volume, scope, or magnitude is growing or spreading over time, rather than static or intermittent → justifies recommending above what the raw score alone would indicate.
- **Criticality override (Branch Q6):** the affected component is pre-designated as critical (payment processing, auth-adjacent infrastructure, safety-critical control) → same.

A finding can trigger both overrides simultaneously — they are independent checks, not alternatives.
