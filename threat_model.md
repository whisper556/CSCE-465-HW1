# Threat Model — Webpage-Summary Workflow

CSCE 465/765 Homework 1, Task 4
Diagram: `attack-surface-map.pdf`

---

## Assets

1. Filesystem integrity inside the VM, especially `hw1/markers/marker.txt`.
2. The model credential (TAMUS API key or local Ollama placeholder).
3. Integrity of the agent context — the token stream every tool call is derived from.
4. OpenClaw configuration and skill definitions, including the exec-policy itself.

---

## Principals

1. Student user — sole legitimate authority over the control channel.
2. OpenClaw gateway / agent process — acts on the user's behalf with delegated tool privileges.
3. Model provider — local Ollama or shim → TAMUS → upstream model; proposes tool calls but holds no independent authority.

---

## Trust boundaries

1. Host ↔ VM — NAT network boundary.
2. Control channel ↔ data channel — where retrieved page text joins typed instructions in one context.
3. VM ↔ model provider — loopback socket or shim → TAMUS → upstream.
4. Tool decision ↔ OS execution — where the exec-policy sits.

---

## Threats and controls

1. **T1 — Indirect prompt injection:** text in `adversarial.html` is treated as user intent, producing an unrequested `safe-marker` call; controlled by delimiting retrieved content and auditing calls with no matching user turn.
2. **T2 — Argument injection:** `safe_marker.sh` could pass its argument to a shell and run a second program; controlled by a strict allowlist accepting only the literal `course-marker`.
3. **T3 — Credential leakage:** the API key could end up in `openclaw.json` or committed evidence; controlled by keeping it only in the shim's environment and grepping commits for it.
4. **T4 — Unauthorized tool execution:** a tool call runs with no authorization decision because the exec policy is permissive; controlled per the exec-policy section below.
5. **T5 — Scope escape:** the agent writes outside `~/csce465-agentsec/hw1/`; controlled by workspace scoping and OS-level confinement.
6. **T6 — Untraceable tool call:** an injected call succeeds and leaves no distinguishable trace; controlled by audit logging that records each call's originating turn and channel.

---

## Effective exec-approval policy

*Control (or missing control) on the skill/tool-decision boundary.*

**Literal output:**
```
$ openclaw exec-policy show

Exec Policy
┌────────────────┬───────────────────────────────────────────────────┐
│ Field          │ Value                                             │
├────────────────┼───────────────────────────────────────────────────┤
│ Config         │ ~/.openclaw/openclaw.json                         │
│ Approvals      │ ~/.openclaw/exec-approvals.json                   │
│ Approvals File │ missing                                           │
└────────────────┴───────────────────────────────────────────────────┘

Effective Policy
┌────────────┬───────────────┬──────────────┬────────────────────────┐
│ Scope      │ Requested     │ Host         │ Effective              │
├────────────┼───────────────┼──────────────┼────────────────────────┤
│ tools.exec │ host=auto     │ security=ful │ security=full\nask=off │
│            │ (OpenClaw     │ l (inherits  │                        │
│            │ default       │ requested    │                        │
│            │ (auto))\nsecu │ tool         │                        │
│            │ rity=full     │ policy)\nask │                        │
│            │ (OpenClaw     │ =off         │                        │
│            │ default       │ (inherits    │                        │
│            │ (full))\nask= │ requested    │                        │
│            │ off           │ tool         │                        │
│            │ (OpenClaw     │ policy)\nask │                        │
│            │ default       │ Fallback=den │                        │
│            │ (off))        │ y (OpenClaw  │                        │
│            │               │ default      │                        │
│            │               │ (deny))      │                        │
└────────────┴───────────────┴──────────────┴────────────────────────┘
```

**What it governs:** It determines whether a tool call proposed by the model requires user approval before it executes, or runs automatically.

**Direct trial:** The policy allowed the call to run without a prompt, which is consistent with the intent since it was explicity asked

**Indirect trial:** The same policy allowed the call to run, however it ignored the injection

**Limitation:** Exec-policy only evaluates whether a given command should be allowed to run, not which channel. the request for it originated from, so it can't by itself distinguish a legitimate request from a injected one.

