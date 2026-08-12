# Definitions

## QSP — Quantum Security Probe

A non-intrusive security probing and measurement capability that operates primarily through available telemetry and metadata rather than inspecting packet contents or intercepting production payloads.

QSP assesses security-relevant changes in system execution and infrastructure behavior using observable signals such as cryptographic operations, execution timing, resource utilization, system behavior, and other measurable characteristics that may reveal anomalous or potentially exploitable behavior.

QSP should not automatically classify a deviation as an attack. Its role is to identify and characterize meaningful deviations from an appropriate baseline and provide evidence for further investigation.

## STG — Sentient TrustGraph

A behavioral trust framework that models expected relationships, actions, and interaction patterns among users, services, AI agents, APIs, infrastructure components, and other entities.

STG is broader than identity/session anomaly detection. It can make granular trust decisions while AI automates routine work — e.g. an AI agent may be permitted to perform dozens of mundane actions automatically while a specific high-risk button, transaction, approval, or privileged action remains exclusively under authorized human control.

STG can also incorporate user-input kinematics and behavioral biometrics: keyboard typing cadence, mouse movement, velocity, pauses, jerks, click patterns, double-clicks, interaction sequences, and other characteristics of how a user interacts with an input device. These signals establish a behavioral baseline and help identify anomalies that credentials alone cannot detect.

Example: a system administrator may legitimately access a VP's desktop while performing maintenance, but STG can recognize that the administrator's interaction signature doesn't match the VP's established behavioral pattern, and prevent, challenge, or require additional authorization for a VP-level transaction as a result.

## Behavioral Physics

The analytical approach used to examine measurable behavioral and execution characteristics of systems and humans and identify meaningful deviations from established baselines.

Behavioral Physics spans both system execution characteristics and human interaction kinematics — it should never be reduced to timing analysis alone.

## Core architectural principle

QSP and STG operate through non-intrusive telemetry, metadata, behavioral history, execution characteristics, identity context, and interaction signals wherever possible. They should not require packet-content inspection or invasive modification of production traffic.

This is a design constraint, not a marketing claim: any finding or recommendation this skill produces should stay within what's observable through telemetry/metadata/behavioral signals. If a proposed investigative step would require packet-content inspection or intercepting production payloads, flag that explicitly as a departure from the non-intrusive default rather than folding it silently into the recommendation.
