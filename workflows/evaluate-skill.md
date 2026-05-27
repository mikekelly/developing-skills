# Workflow: Evaluate Skill Behavior

<required_reading>
**Read these files NOW:**
1. knowledge/iteration-and-testing.md
2. knowledge/evaluation-driven-development.md
3. knowledge/skill-structure.md
4. knowledge/skill-checklist.md
5. templates/evals.json
6. templates/grading.json
7. templates/evaluation-report.md
</required_reading>

<purpose>
Evaluate checks whether a skill changes agent behavior in the intended direction. It is not the same as an audit: audit checks structure, verification checks factual accuracy, evaluation checks outcomes on realistic tasks.
</purpose>

<escalation_triggers>
Stop and ask when:
- The user wants quantitative benchmarking but no observable success criteria can be defined
- Test prompts require private files, credentials, or external services the agent cannot safely access
- The skill's expected behavior is mostly subjective and the user has not agreed to qualitative review
- Running the evals would modify production systems or user data
</escalation_triggers>

<process>
## Step 1: Select Skill and Rigor

If the user already named a skill path, use it. Otherwise ask for the path.

Choose the lightest evaluation that answers the question:

| Mode | Use When | Output |
|------|----------|--------|
| **Lightweight** | Personal skill, quick sanity check, subjective outputs | 2-3 realistic prompts, qualitative notes |
| **Rigorous** | Public/reusable skill, risky workflow, performance claim | Baseline comparison, assertions, timing/token notes where available |
| **Regression** | Skill was changed and needs comparison | Old-skill or previous-iteration baseline |

Default to lightweight unless the user asks for benchmarking, the skill is intended for distribution, or the change has high blast radius.

## Step 2: Read Skill and Identify Claims

Read:
```bash
cat {skill-path}/SKILL.md
ls {skill-path}/
ls {skill-path}/workflows/ 2>/dev/null
ls {skill-path}/knowledge/ 2>/dev/null
ls {skill-path}/evals/ 2>/dev/null
```

Extract:
- Intended trigger contexts from the description
- Main workflows and expected outputs
- Constraints the skill claims to enforce
- Reusable scripts/templates the skill should cause the agent to use

## Step 3: Draft Realistic Evaluation Prompts

If the skill already has `evals/`, read those first and reuse or extend them instead of starting from a blank template.

Create 2-5 prompts that look like real user requests. Include:
- Typical successful path
- At least one edge case or ambiguous request
- At least one prompt that should exercise a distinctive skill behavior

For each prompt, define observable expectations:
```json
{
  "id": "descriptive-name",
  "prompt": "Realistic user request",
  "files": [],
  "expected_behavior": [
    "Specific behavior that can be observed in the output or transcript",
    "Specific constraint the agent should follow"
  ],
  "review_mode": "qualitative|assertion|script"
}
```

Share the prompts with the user for review when the evaluation is user-facing or expensive. Do not overfit prompts to exact wording in the current skill.

## Step 4: Choose Baseline

Pick the baseline that matches the work:

| Situation | Baseline |
|-----------|----------|
| New skill | Same prompt without the skill |
| Improving existing skill | Snapshot before changes |
| Comparing two revisions | Previous iteration or named revision |
| No baseline possible | Skill-only run with explicit limitation |

For existing-skill regression, snapshot before editing:
```bash
cp -R {skill-path} {workspace}/skill-baseline
```

## Step 5: Run Evaluations

Create an evaluation workspace next to the skill or in a temp directory:
```text
{skill-name}-evals/
  iteration-1/
    evals.json
    {eval-id}/
      with_skill/
      baseline/
```

Run each prompt in a fresh context when the harness allows it. If parallel workers are available and permitted, run with-skill and baseline variants in the same evaluation round. Otherwise run them sequentially and record that limitation.

Capture for each run:
- Final output and files created
- Notes on which skill files were read
- Timing/token data if the harness exposes it
- Any errors, refusals, or unexpected exploration paths

## Step 6: Grade and Analyze

For each expected behavior, mark:
```json
{
  "text": "Expected behavior",
  "passed": true,
  "evidence": "Short evidence from output, file, or transcript"
}
```

Prefer scripts for assertions that can be checked deterministically. Use qualitative review for style, judgment, design taste, or broad reasoning quality.

Then analyze:
- Behaviors the skill improves over baseline
- Behaviors that fail with and without the skill, indicating weak eval design or missing user context
- Behaviors that only pass because the prompt mirrors the skill wording, indicating overfitting
- Token/time overhead that is not buying useful behavior
- Repeated helper code or manual steps that should become `scripts/`, `templates/`, or clearer workflow guidance

## Step 7: Review With the User

Before revising the skill, put the outputs in front of the user when the evaluation is subjective, user-facing, or expensive to rerun. Show:
- Prompt
- With-skill output
- Baseline or previous output, if available
- Formal grades or assertion results, if used
- Specific questions where user judgment is needed

If the environment supports a browser or review artifact, use it. Otherwise summarize inline and link to output files. Empty or approving feedback means the output is acceptable; focus changes on specific complaints or failed assertions.

## Step 8: Recommend Changes

Generalize from evidence instead of patching for one prompt:
- If the agent missed a step, clarify the decision point or success criteria
- If the agent read the wrong files, improve routing and required_reading
- If the agent wasted tokens, remove instructions that do not pull their weight
- If each run recreated the same helper, bundle it in `scripts/`
- If the skill failed to load, route to workflows/optimize-description.md

## Step 9: Optional Blind Comparison

Use blind comparison when two skill versions produce subjective outputs and the user asks which is better. Present outputs without labeling which version produced them, have an independent reviewer or the user judge quality against explicit criteria, then analyze why the winner performed better.

Skip blind comparison for straightforward deterministic assertions.

## Step 10: Iterate

After changes:
1. Rerun the same evals in `iteration-{N+1}/`
2. Compare with the previous iteration and baseline
3. Keep changes that improve meaningful outcomes
4. Stop when feedback is empty, metrics plateau, or the next change would overfit the eval set
</process>

<report_format>
Present results as:

```markdown
## Evaluation Report: {skill-name}

### Setup
- Mode: Lightweight/Rigorous/Regression
- Baseline: No skill/Old skill/Previous iteration/None
- Evals: N prompts

### Results
| Eval | With Skill | Baseline | Notes |
|------|------------|----------|-------|
| descriptive-name | pass/fail | pass/fail | key evidence |

### Findings
1. [Behavioral finding grounded in evidence]
2. [Behavioral finding grounded in evidence]

### Recommended Changes
- [Specific skill edit]
- [Specific skill edit]
```

Use `templates/evaluation-report.md` when writing a full report.
</report_format>

<success_criteria>
Evaluation is complete when:
- [ ] Skill behavior claims are identified
- [ ] Realistic eval prompts and expectations are defined
- [ ] Baseline is chosen or explicitly waived
- [ ] Results are captured with evidence
- [ ] Subjective or user-facing outputs are reviewed by the user before major revision
- [ ] Recommendations generalize beyond a single prompt
- [ ] User understands whether the skill improved behavior
</success_criteria>
