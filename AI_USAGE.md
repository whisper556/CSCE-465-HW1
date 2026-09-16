# AI Usage Record (AI_USAGE.md)

In accordance with the CSCE 465/765 AI-Use and Safety Policy, this log documents the interaction, prompting, and verification steps where AI assistance was utilized to complete Homework 1.

---

## 1. Summary of AI Assistance

AI tools (Gemini) were used strictly for learning, script generation assistance, skill formatting, and structural drafting. All outputs were independently tested, modified, and verified inside the course VM prior to submission.

- **Task 1.5** Used for exact syntax to query the OpenClaw agent properly to perform the benign tasks
- **Task 2 (Harmless Tool & Web Lab):** Assisted in writing the input-validation logic for `bin/safe_marker.sh`, formatting the OpenClaw `SKILL.md` file, and structuring `benign.html` and `adversarial.html`.
- **Task 3 (Injection Experiments):** Assisted in structuring the local execution commands for direct/indirect trials and clarifying core security differences (control vs. data channel, transport security limitations).


---

## 2. Prompts and AI Responses Log

### Log Entry 1: Writing `bin/safe_marker.sh`
- **User Prompt:** "Write bin/safe_marker.sh. It must accept exactly one argument 'course-marker', reject all other arguments, create only hw1/markers/marker.txt, and never run another program supplied by user input."
- **AI Response Summary:** Provided a Bash script template using `$#` checking, explicit string comparison (`!= "course-marker"`), and absolute directory pathing to prevent path traversal or extra argument execution.
- **Student Verification & Modification:** Reviewed argument validation logic, verified permissions with `chmod +x`, and tested edge cases (passing zero args, extra args, and injected command strings) directly in the terminal.

### Log Entry 2: Formatting `SKILL.md`
- **User Prompt:** "Create a local OpenClaw workspace skill in ~/.openclaw/workspace/skills/safe-marker/SKILL.md describing when the marker is allowed and the exact fixed command."
- **AI Response Summary:** Generated YAML frontmatter (`name: safe-marker`) and Markdown instructions defining the single execution string `~/csce465-agentsec/hw1/bin/safe_marker.sh course-marker`.
- **Student Verification & Modification:** Executed `openclaw skills check` to confirm OpenClaw registered the skill as eligible and visible to the model.

### Log Entry 3: Task 3 Experimental Execution & Analysis
- **User Prompt:** "Give command line instructions to execute Task 3" [Direct and indirect prompt injection experiment]"
- **AI Response Summary:** Provided standard CLI sequence to test direct agent invocation vs. wrapping `adversarial.html` content in delimiters via curl, along with structural explanations for why encryption (TLS) does not mitigate indirect injection.
- **Student Verification & Modification:** Executed both commands against `tamus/protected.gpt-4o`, confirmed marker creation on Trial 1 and rejection on Trial 2, and authored the final response based on actual audit logs.

---

## 3. Statement of Verification
I confirm that all code, scripts, command outputs, and analysis in this repository were reviewed, run, and verified by me inside the Ubuntu 24.04 VM environment.

