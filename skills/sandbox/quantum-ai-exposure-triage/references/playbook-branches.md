# Playbook branches

Full IF/THEN logic. Pick the branch that matches what's actually corroborating — don't force a finding into Branch C just because it would justify a stronger call than the evidence supports.

## Branch A — Cryptographic exposure without behavioral evidence

**IF:**
- Cryptographic posture is weak, outdated, or exposed to future quantum risk;
- STG behavioral relationships remain consistent;
- QSP execution measurements remain within calibrated baseline.

**THEN:**
- Classify primarily as architectural or cryptographic exposure, not active compromise.
- Assess data sensitivity and harvest-now-decrypt-later exposure.
- Prioritize PQC migration and cryptographic-agility remediation.
- Do not interrupt production solely because of cryptographic technical debt.

## Branch B — Behavioral trust deviation

**IF:**
- Cryptographic posture is acceptable;
- STG identifies a meaningful identity, relationship, sequence, privilege, user-input, or interaction anomaly;
- QSP provides no corroborating execution anomaly.

**THEN:**
- Classify as behavioral anomaly or suspected trust abuse.
- Investigate credential/token misuse, changed service dependencies, privilege escalation, configuration changes, legitimate operational explanations, and possible human/device mismatch.
- Escalate according to privilege, asset criticality, action criticality, and attack-path relevance — not on the anomaly alone.

## Branch C — Correlated behavioral and execution anomaly

**IF:**
- STG detects a meaningful behavioral deviation;
- QSP independently detects a persistent execution/resource anomaly;
- Both occur within the same relevant transaction, process, or time window;
- The baseline is sufficiently reliable;
- Plausible benign explanations have been investigated.

**THEN:**
- Substantially increase compromise confidence.
- Investigate compromised dependencies, malicious updates, injected code, unauthorized functionality, credential abuse, or supply-chain compromise.
- Recommend containment when the evidence, asset criticality, and attack path justify it.

This is the branch that most often justifies a CONTAIN/BLOCK call — because it's the only one where two independent signals corroborate each other in the same window.

## Branch D — Trusted software / valid signature

**IF:**
- A binary, package, update, or dependency has a valid signature;
- Provenance appears legitimate;
- Conventional security controls report normal;
- BUT observed behavior materially deviates from an established baseline.

**THEN:**
- Do not treat the valid signature as exculpatory.
- Treat provenance, signature validity, behavioral integrity, and execution behavior as separate evidence dimensions.
- Investigate the discrepancy — this is often the entry point into Branch C once QSP/STG corroboration is checked.

## Branch E — AI automation with a human-control boundary

**IF:**
- An AI agent is performing routine authorized actions;
- A specific action is designated as high-risk, irreversible, financially sensitive, privileged, or identity-sensitive.

**THEN:**
- Allow the AI to continue automating approved routine actions.
- Retain the designated high-risk action under authorized human control.
- Use STG identity, behavioral, contextual, and kinematic signals to determine whether the human interaction is consistent with the expected authorized user.
- Challenge, pause, or deny the action when trust conditions are not satisfied.

## Branch F — Human / device behavioral mismatch

**IF:**
- Authenticated identity is valid;
- Authorization is valid;
- BUT STG detects a significant mismatch between the current interaction kinematics and the established user's behavioral baseline.

**THEN:**
- Treat the mismatch as an additional risk signal rather than automatically declaring compromise.
- Evaluate context: maintenance activity, shared devices, unusual working conditions, accessibility factors, legitimate delegation.
- Increase authentication or authorization requirements for high-risk actions when the mismatch stands after that review.
