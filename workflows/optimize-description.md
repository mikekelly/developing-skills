# Workflow: Optimize Skill Description and Triggering

<required_reading>
**Read these files NOW:**
1. knowledge/skill-structure.md
2. knowledge/iteration-and-testing.md
3. knowledge/be-clear-and-direct.md
4. templates/trigger-evals.json
</required_reading>

<purpose>
The description is the matching surface that determines whether an agent loads the skill. This workflow improves trigger accuracy by testing realistic should-trigger and should-not-trigger prompts, then revising the frontmatter description based on observed failures.
</purpose>

<escalation_triggers>
Stop and ask when:
- The skill overlaps heavily with another skill and the ownership boundary is unclear
- The user wants the skill to trigger for broad generic requests that should usually be handled without a skill
- Description changes would make the skill misleading about what it actually does
</escalation_triggers>

<process>
## Step 1: Read Current Skill Metadata

Read:
```bash
sed -n '1,40p' {skill-path}/SKILL.md
```

Extract:
- `name`
- current `description`
- explicit activities covered
- trigger contexts
- nearby skills that could compete, if visible

Check the description against core requirements:
- Says what the skill does
- Says when to use it
- Covers all activity synonyms the skill handles
- Avoids implementation details
- Uses proactive language only when the skill should guide work from the start

## Step 2: Build Trigger Eval Set

Create 16-20 realistic prompts:
- 8-10 **should trigger**
- 8-10 **should not trigger**

Use prompts a real user would type. Include casual phrasing, partial context, filenames, domain details, typos, and edge cases. Make negative cases near misses, not obviously irrelevant prompts.

Schema:
```json
[
  {
    "query": "Realistic user prompt",
    "should_trigger": true,
    "reason": "Why this should or should not load the skill"
  }
]
```

Use `templates/trigger-evals.json` as the starting point when saving the eval set.

Good trigger eval prompts are substantive. Avoid one-step generic prompts such as "format this data" unless the skill truly exists for that exact broad task.

## Step 3: Review Boundaries

Before changing the description, classify failures:

| Failure Type | Likely Fix |
|--------------|------------|
| Misses relevant task | Add missing activity verb or domain phrase |
| Triggers on adjacent task | Narrow trigger condition or add boundary language |
| Confuses with another skill | Clarify ownership and when this skill wins |
| Does not trigger for simple one-step task | May be acceptable if no specialized workflow is needed |
| Triggers too late | Add proactive timing language |

Do not optimize for perfect recall if it causes harmful over-triggering. A useful description is specific enough that the agent can confidently choose it.

## Step 4: Draft Revised Description

Write 2-3 candidate descriptions. Keep each candidate:
- Under 1024 characters
- Quoted for YAML safety
- Free of implementation details
- Focused on user intent and activities
- Directly addressed to the deciding agent with "Use when..." or "MUST be loaded before..." as appropriate

Prefer this structure:
```yaml
description: "{Capabilities}. Use when {trigger contexts}. {Optional proactive timing or boundary}."
```

## Step 5: Score Candidates

Evaluate each candidate against the trigger eval set:
- Should-trigger prompts: would a reasonable agent load the skill?
- Should-not-trigger prompts: would a reasonable agent skip it?
- Boundary prompts: is the intended owner clear?

Summarize scores:
```text
current: 13/20
candidate A: 17/20
candidate B: 16/20
```

If the harness can empirically test skill loading, run the prompts in fresh contexts. If not, do a reasoned manual scoring pass and label it as manual.

## Step 6: Apply Best Description

Update only the frontmatter description unless the trigger evals reveal real scope problems in the skill body.

After applying, verify:
```bash
sed -n '1,20p' {skill-path}/SKILL.md
```

Report:
- Before description
- After description
- Trigger eval score
- Remaining ambiguous cases
</process>

<description_patterns>
## Good Patterns

**Proactive lifecycle skill:**
```yaml
description: "MUST be loaded before working with any Skill. Covers creating, reviewing, auditing, updating, and improving skills."
```

**Reactive task skill:**
```yaml
description: "Extracts text and tables from PDFs, fills PDF forms, and merges documents. Use when working with PDF files or document extraction."
```

**Boundary-aware skill:**
```yaml
description: "Creates and edits PowerPoint or Google Slides decks. Use when building, revising, rendering, or exporting presentation slides; do not use for ordinary prose documents."
```
</description_patterns>

<success_criteria>
Description optimization is complete when:
- [ ] Current description and skill scope are understood
- [ ] Should-trigger and should-not-trigger eval prompts exist
- [ ] Near-miss boundary cases are included
- [ ] Candidate descriptions are scored
- [ ] Best description is applied or recommended
- [ ] Remaining trigger risks are documented
</success_criteria>
