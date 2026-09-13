# Long Horizon Agent for PQC Migration — Vijay + Indu Exploration

**Status:** Exploratory technical notes derived from a recorded conversation. Not a product specification, not a commitment to a production architecture, not a claim about Factory AI's actual capabilities.

**Source:** ~7.5-minute recorded conversation between Vijay (Vyapti Resonance) and Indu, on post-quantum cryptography migration and whether long-horizon AI agents could meaningfully assist with it. Transcribed locally via automatic speech recognition (Whisper-base, no speaker diarization). Speaker names and one company name were not reliably captured by the transcription and are referred to by role below rather than guessed at.

**Purpose of this document:** give Utopia enough real technical context to run their own independent experiment with Factory AI — not to hand them a finished spec.

**Epistemic key used throughout:**
- 🟢 **EXPLICIT** — Vijay or Indu said this directly in the recording (paraphrased or lightly summarized, not invented)
- 🟡 **HYPOTHESIS** — a reasonable inference from what was said, not stated outright
- 🔴 **UNKNOWN** — genuinely open, needs to be tested rather than assumed

---

## 1. Executive Summary

**The problem:** enterprises need to migrate classical cryptography (RSA, ECDSA, ECDH, etc.) to post-quantum or hybrid alternatives. Doing this safely requires knowing where crypto is actually used, what depends on it, and whether a change breaks anything — before, during, and after the change. 🟢

**Why long-horizon agents may be useful:** the opening framing of the conversation is explicit that the interest is *not* in a scanner that produces a report. It's in whether an agent can investigate dependencies, reason about migration challenges, make a controlled change, test it, learn from failures, and keep working toward a validated solution — i.e., something closer to a bounded engineering task than a one-shot audit. 🟢

**What we are NOT claiming yet:**
- That an agent can safely modify production systems. Nothing in the conversation suggests this — the one demonstration scenario described is explicitly a small, isolated, non-production client-server setup. 🟢
- That Factory AI specifically can do any of this. Factory AI is never named in the recording; it is Utopia's own tool to test this against, not something Vijay/Indu evaluated. 🟡/🔴
- That this connects to QSP. QSP is never mentioned in the recording either — any relationship is drawn afterward, not from this conversation. See Section 10. 🔴
- That a specific migration technique, algorithm choice, or automation percentage was agreed on. None was. 🔴

---

## 2. PQC Migration Problem

What makes this hard, per Indu's answers in the conversation:

- **Crypto discovery** — a lot is detectable automatically from source code, dependencies, configuration, certificates, and build files: RSA, ECDSA, ECDH, TLS versions, cipher suites, certificates, crypto libraries. 🟢
- **But detection alone isn't enough** — the agent also needs to understand *why* the crypto is being used: encryption, authentication, signing, certificate exchange. Detection tells you *what* exists; it doesn't tell you *what it means*. 🟢
- **Dependencies** — real difficulty starts when cryptography is hidden inside dependencies, protocols, certificates, and application workflows. Finding an RSA key is easy; knowing which component uses it, what depends on it, whether it can be replaced, and whether changing it breaks interoperability is the hard part. 🟢
- **Protocol/application context** — before changing anything, four things need to be understood: the crypto's *role* (what the algorithm is doing), *where* it's used, its *dependencies* (which libraries/frameworks/versions), and *interoperability* (can the other endpoint support the new algorithm). Plus certificates, performance, compatibility, security requirements, and compliance. 🟢
- **The explicit warning:** "we should not simply say replace RSA with ML-KEM — we first need to understand the role, protocol, dependencies and endpoints." 🟢
- **Testing and validation** — establishing a real before/after baseline: run the existing (already-built) application and its tests before any change, record the TLS protocols and crypto configuration; after the change, rebuild, run the same tests, verify protocol and interoperability, check performance. If something fails, the agent should show and explain the failure rather than hide it or edit unrelated code to force the test to pass. 🟢

---

## 3. Proposed Agent Workflow

This is the closest thing to a directly-stated workflow in the conversation — it maps almost one-to-one onto Indu's answer to "if the agent had 24–48 hours instead of 10 minutes, what should it keep doing":

> "It should discover, reason, plan, implement, test, learn from failures, retry, validate, and report. If it finds an unknown dependency, it should investigate it. If a migration fails, it should understand why, adjust the approach, test again, and continue until it reaches a defined stopping condition." 🟢

Expressed as the smallest realistic workflow, combining that answer with the assessment/demonstration/verification steps described earlier in the conversation:

```
Discover        → find crypto usage from source, deps, config, certs, build files
Understand      → why is this crypto used (auth / signing / encryption / cert exchange)
Assess          → role, dependencies, interoperability, business/quantum risk, complexity
Plan            → recommend the safest change — do not assume the migration in advance
Implement        → a single bounded change, in an isolated environment
Test            → same tests before and after; protocol + interoperability + performance
Learn from failures → investigate unknown dependencies; explain failures, don't hide them
Validate        → before/after evidence, not a self-reported "it passed"
Report          → what changed, what was verified, what remains uncertain
```

🟢 Every step above traces to something said in the recording. Nothing here adds a step (e.g. no "auto-deploy," no "rollback," no "multi-repo orchestration") that wasn't discussed.

---

## 4. Smallest Useful Proof of Concept

**Explicitly described in the conversation:** a small, controlled client-server application, where the agent:
1. Identifies the existing classical TLS configuration
2. Determines whether a PQC or hybrid option is supported
3. Makes a change in an isolated environment
4. Rebuilds the application
5. Verifies communication still works

Summarized in the conversation itself as: *"discover, change, build, test, verify."* 🟢

**The explicit caveat:** "I would not assume the migration beforehand. I would let the agent investigate the application and then recommend the safest change." — i.e. the PoC should not start from a pre-decided algorithm swap; it should start from the agent's own investigation. 🟢

**What this means for a Factory AI experiment (🟡 hypothesis, not stated in the recording):** pick one small repository with a real classical-TLS client-server component (not a toy that already has PQC support pre-wired, and not a large enterprise codebase). Ask Factory AI to run the workflow in Section 3 against it, scoped to *one* bounded change — not a full migration.

**Genuinely open (🔴):** which repository, which language/stack, and what "small" means in practice were not discussed. This needs to be picked based on what's actually available to Utopia to test against.

---

## 5. Inputs

What the agent would receive, per the conversation:

- The application's source code, dependencies, and configuration/build files 🟢
- Access to certificates and TLS configuration in use 🟢
- The ability to build and run the application (to establish a before-baseline and re-run after) 🟢
- An isolated environment to make changes in, separate from anything production 🟢

Not discussed (🔴): whether the agent gets a written spec of the target PQC/hybrid algorithm, or discovers viable options itself. The conversation implies the latter ("determines whether a PQC or hybrid option is supported") but this isn't spelled out as an instruction format.

---

## 6. Agent Outputs

Outputs directly justified by the conversation:

- **Crypto inventory** — what algorithms/protocols were found, where, via source/dependency/config/certificate/build-file analysis 🟢
- **Findings on usage context** — what each crypto component protects and why (auth, signing, encryption, cert exchange) 🟢
- **Migration assessment** — role, dependencies, interoperability, and a priority ordering based on quantum risk, business impact, data lifetime, and technical complexity 🟢
- **Proposed change** — a specific, safest recommended change for the one bounded scenario, not assumed in advance 🟢
- **Implementation diff** — the actual code/config change made in the isolated environment 🟢 (implied by "makes a change... rebuilds... verifies")
- **Test results, before and after** — same test suite, before and after the change 🟢
- **Before/after evidence** — recorded TLS protocol and crypto configuration state, pre- and post-change, plus performance comparison 🟢
- **Explained failures** — if something breaks, a stated explanation, not a silent skip or an unrelated code change to force a pass 🟢
- **Remaining uncertainties** — implied by the "investigate unknown dependencies" and "continue until a defined stopping condition" language, though the conversation doesn't specify the output format for this 🟡

---

## 7. Human Approval / Safety Boundaries

The conversation doesn't use the phrase "human approval," but several boundaries are explicit or directly implied:

- 🟢 **Changes happen in an isolated environment**, not production — stated directly for the demonstration scenario.
- 🟢 **No hiding failures** — "the agent should show the failure and explain it, rather than hiding it or changing unrelated code just to make the test pass." This is as close to a stated safety principle as the conversation gets.
- 🟢 **No pre-assumed migration** — the agent investigates and recommends, rather than being told what to implement — which also means a human presumably reviews and decides whether to accept the recommendation, though this hand-off point isn't spelled out.
- 🟡 **Hypothesis, not stated:** a human should approve before any recommended change is applied outside the isolated test environment; a human should approve before the agent is pointed at anything resembling production or real customer infrastructure; a human should review the crypto inventory/assessment before the agent proceeds to implementation, given how much of the difficulty (per Section 2) is in correctly understanding *why* crypto is used, not just detecting it.
- 🔴 **Unknown:** whether Factory AI has any built-in mechanism for a human-approval checkpoint mid-task, or whether this would need to be designed as part of the experiment.

---

## 8. Measurable Success Criteria

Directly from the conversation's own definition of "how would we know the migration didn't break the application":

- 🟢 Before-baseline established: existing tests pass, TLS protocol and crypto configuration recorded, before any change.
- 🟢 After the change: same tests re-run, protocol and interoperability verified, performance checked against the baseline.
- 🟢 Any failure is explained, not hidden or worked around by editing unrelated code.

For the PoC specifically (🟡 hypothesis, extending the above to a go/no-go framing):
- Did the agent correctly identify the existing classical TLS configuration, without being told in advance?
- Did it correctly determine whether a PQC/hybrid option was available for that stack?
- Did the before/after test results and protocol evidence actually get produced, not just asserted?
- If it failed, did it explain *why*, in terms a reviewer could evaluate?

🔴 No numeric thresholds (accuracy %, time limits beyond the "24–48 hours vs. 10 minutes" framing, pass/fail rates) were discussed. Don't invent one for the experiment without deciding it deliberately.

---

## 9. Factory AI Experiment Questions

Things to let the experiment answer, rather than assume going in:

- Can Factory AI actually execute a multi-step "discover → reason → plan → implement → test → learn from failures → retry → validate → report" loop autonomously, or does it need a human in the loop at each step?
- When it hits an unknown dependency, does it investigate, or does it stall/hallucinate?
- When a test fails after a crypto change, does it explain the failure honestly, or does it try to force the test to pass by editing unrelated code (the exact failure mode Indu explicitly warned against)?
- Does it default to assuming a migration path (e.g., "just replace RSA with ML-KEM"), or does it actually investigate role/dependencies/interoperability first, as the conversation insists it should?
- How long can it stay productively on-task before it needs to be re-grounded or re-prompted — is "24–48 hours" of autonomous work realistic, or does useful autonomy top out much sooner?
- What does a defined "stopping condition" look like in practice for Factory AI — does the platform support one, or does that need to be built into the prompt/harness?

---

## 10. Relationship to QSP

🔴 **QSP is not mentioned anywhere in this conversation.** This section is a hypothesis about how the two efforts *could* relate, not something Vijay and Indu discussed or established.

🟡 **Hypothesis:** if a long-horizon agent produces before/after evidence (protocol state, crypto configuration, test results — Section 8) as part of a PQC migration task, QSP's existing role as a runtime observability/evidence layer could plausibly provide independent verification of that evidence, rather than relying solely on the agent's own self-report. This would fit the same "don't trust the agent's own claim of success" principle Indu stated about testing.

This is speculative and should not be treated as scoped work. If it's worth pursuing, it needs its own separate discussion — it should not be assumed as part of the Factory AI experiment itself.

---

## 11. What This Could Become

🔴 **Future / hypothesis only — not committed scope.**

If a small-scale experiment shows a long-horizon agent can meaningfully execute the discover→report loop on a bounded, isolated task, the natural next questions (not answered here) would be: how far can the scope realistically grow (more languages/stacks, larger codebases); what a human-approval checkpoint should formally look like; whether independent evidence verification (Section 10) is worth building; and whether this becomes a reusable internal capability versus a one-off proof point. None of this is decided, and the conversation itself doesn't go this far — this section exists only to name the direction, not to commit to it.

---

## 12. One-Paragraph Message to Karan

> Hey Karan — sharing the gist of the PQC conversation Indu and I had. The core idea we landed on: don't build a tool that just scans a codebase and spits out a crypto report — build (or test) an agent that actually investigates a real, small application end to end: find where crypto is used, understand *why* it's used and what depends on it, propose the smallest safe change, make it in an isolated environment, and prove with before/after test evidence that nothing broke — and if something does break, it should explain why rather than quietly work around it. That last part is basically the definition of a long-horizon agent versus a one-shot scanner: it keeps investigating, learns from failures, and retries until it hits a real stopping point instead of stopping at the first report. I think this is a good, bounded first experiment for Factory AI — pick one small repo with real TLS/crypto in it, and see whether it can actually run that discover-to-report loop on its own, or where it needs a human to step in. I haven't tested Factory AI's actual capabilities myself, so I'd rather Utopia run this experiment independently and tell me what you find, instead of me guessing at what it can do.

---

*Document prepared from a single ~7.5-minute recorded conversation. Speaker turns were inferred from conversational context (no audio diarization was available), so a small number of individual attributions above may not be perfectly precise — the substance of what was said is preserved faithfully either way.*
