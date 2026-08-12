# Worked example: signed vendor update, Branch C

## Scenario

An enterprise AI agent receives a signed update from a trusted third-party vendor.

**Initial telemetry:**
- Vendor signature is valid.
- TLS certificate is valid.
- Expected vendor endpoint is used.
- Expected API identity authenticates successfully.
- Expected update schedule is followed.
- Conventional vulnerability and endpoint scanners report no critical finding.

**Conventional assessment:** the update is considered trusted. Full stop, on a compliance-scan basis.

## Where this skill diverges

**QSP observation:** a persistent execution-time and resource-utilization deviation compared with a well-established baseline. The deviation occurs specifically while the newly updated component processes the update.

**STG observation:** a previously unusual interaction sequence involving a privileged downstream service, during the same processing window.

**Additional investigation, before scoring:**
- The deviation is reproducible under controlled replay.
- The behavioral change began immediately after the update.
- Normal workload variation does not adequately explain it.
- Deployment records confirm the new component is the relevant change.
- No confirmed malicious code or command-and-control channel has yet been established — this is stated explicitly, not glossed over.

## The expert-level finding

Not: "CPU increased."

**Is:** a trusted, validly-signed artifact introduced a reproducible behavioral change that correlates temporally and operationally with a new privileged interaction path. This is Branch D (valid signature, deviant behavior) immediately escalating into Branch C once the QSP and STG signals are checked for independent corroboration in the same window — which they have.

## Score

| Dimension | Score |
|---|---|
| Cryptographic Exposure | 20/100 |
| Behavioral Trust Deviation | 82/100 |
| Execution / Side-Channel Anomaly | 88/100 |
| **Initial Exposure Priority Score** | **79/100** |

Evidence confidence: high that system behavior changed; medium-to-high that the change is security-relevant; **not yet sufficient** to conclusively state the vendor or update server was compromised. That last line is load-bearing — it's the difference between this brief and a false-attribution one.

## Decision: CONTAIN / ESCALATE

## The brief

> CONTAIN / ESCALATE. A trusted signed component introduced a reproducible execution deviation that coincides with a previously unobserved privileged interaction pattern. Signature and provenance remain valid but are not considered exculpatory. The evidence is consistent with a possible trusted-component or supply-chain compromise, although malicious root cause has not yet been established. Isolate the affected deployment cohort, preserve telemetry, prevent further propagation, and conduct controlled analysis before making a definitive attribution.

## What a conventional audit would have missed

Every signal a compliance scan checks — signature, cert, endpoint, schedule, vulnerability scan — passed. The exposure was only visible by refusing to let those signals vouch for execution behavior and interaction pattern, and by having a baseline reliable enough to notice the deviation in the first place.
