# Common mistakes

Full list. The six most load-bearing are called out in SKILL.md; the rest are still real failure modes to check a brief against.

1. **Signed = safe.** A valid signature provides evidence about authenticity/integrity of the signed artifact, not proof that the artifact is benign.
2. **Authenticated = authorized for everything.** Authentication establishes identity; it does not mean every action should be permitted.
3. **Authorization = behavioral trust.** A user may have permission to perform an action while the current context or interaction pattern indicates additional verification is appropriate.
4. **Anomaly = attack.** An anomaly means something differs from baseline. It does not establish why.
5. **One measurement becomes the verdict.** Timing, CPU, memory, cache behavior, mouse movement, typing cadence, network latency, or another individual signal can have benign explanations.
6. **Poor baselines.** A baseline collected under one workload, device, deployment version, environment, or user context may not remain valid under another.
7. **Confusing network latency with execution behavior.** Where technically possible, separate network-path variability from local execution measurements — they have different causes and different remediation paths.
8. **Correlation without causation.** Two anomalies occurring together increase investigative value but do not automatically prove that one caused the other.
9. **Ignoring legitimate change.** Deployments, configuration changes, feature flags, scaling, model updates, dependency updates, maintenance, accessibility conditions, and workload shifts can all create legitimate behavioral changes — rule these out before escalating.
10. **Treating AI agents exactly like humans.** AI agents can produce highly structured interaction patterns, making sequence, tool-use, and action-graph deviations useful signals — but legitimate AI-agent behavior can also vary, and shouldn't be judged against a human baseline.
11. **Treating human behavioral biometrics as absolute identity proof.** Typing cadence and mouse kinematics are powerful contextual signals but should be treated as probabilistic evidence, not infallible identity proof.
12. **Ignoring attack-path relevance.** A small anomaly in an isolated service is not equivalent to the same anomaly on a path such as identity provider → privileged AI agent → production database. Score attack-path relevance explicitly, don't let it get lost under severity.
13. **Producing a score without evidence.** A numerical score without an evidence trail is not operator judgment — it's noise with a decimal point.
14. **Treating compliance as security.** PQC compliance, valid certificates, vulnerability-free scans, and signed software can all be important controls while still leaving behavioral or supply-chain attack surfaces wide open. This is the entire reason this skill exists — don't let a clean compliance picture quietly downgrade a brief's urgency.
15. **Declaring attribution too early.** Detecting suspicious behavior does not automatically establish which vendor, component, attacker, or campaign caused it. State what changed and how confident the finding is; leave who-did-it to the investigation this brief recommends, not the brief itself.
