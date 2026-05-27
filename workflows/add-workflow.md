# Workflow: Add a Workflow to Existing Skill

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/recommended-structure.md
2. knowledge/workflows-and-validation.md
3. knowledge/llm-wiki-principles.md
</required_reading>

<process>
## Step 1: Select the Skill

Ask directly in chat instead of using a constrained-choice UI; there may be many skills.

```bash
ls {skills-directory}/
```

Present numbered list, ask: "Which skill needs a new workflow?"

## Step 2: Analyze Current Structure

Read the skill:
```bash
cat {skills-directory}/{skill-name}/SKILL.md
ls {skills-directory}/{skill-name}/workflows/ 2>/dev/null
```

Determine:
- **Simple skill?** → May need to upgrade to router pattern first
- **Already has workflows/?** → Good, can add directly
- **What workflows exist?** → Avoid duplication

Report current structure to user.

## Step 3: Gather Workflow Requirements

Ask directly:
- What should this workflow do?
- When would someone use it vs existing workflows?
- What knowledge files would it need?

## Step 4: Upgrade to Router Pattern (if needed)

**If skill is currently simple (no workflows/):**

Ask: "This skill needs to be upgraded to the router pattern first. Should I restructure it?"

If yes:
1. Create workflows/ directory
2. Move existing process content to workflows/main.md
3. Rewrite SKILL.md as router with intake + routing
4. Verify structure works before proceeding

## Step 5: Create the Workflow File

Create `workflows/{workflow-name}.md`:

```markdown
# Workflow: {Workflow Name}

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/{relevant-file}.md
</required_reading>

<process>
## Step 1: {First Step}
[What to do]

## Step 2: {Second Step}
[What to do]

## Step 3: {Third Step}
[What to do]
</process>

<success_criteria>
This workflow is complete when:
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3
</success_criteria>
```

## Step 6: Update SKILL.md

Add the new workflow to:

1. **Intake question** - Add new option
2. **Routing table** - Map option to workflow file
3. **Workflows index** - Add to the list

## Step 7: Create Knowledge Files (if needed)

If the workflow needs domain knowledge that doesn't exist:
1. Create `knowledge/{topic-name}.md`
2. Add it to knowledge_index only if it is a top-level entry point
3. Otherwise connect it through related-page links or the workflow's required_reading
4. Keep it synthesized and source-first; do not dump raw source material into `knowledge/`

## Step 8: Test

Invoke the skill:
- Does the new option appear in intake?
- Does selecting it route to the correct workflow?
- Does the workflow load the right knowledge files?
- Does the workflow execute correctly?

Report results to user.
</process>

<success_criteria>
Workflow addition is complete when:
- [ ] Skill upgraded to router pattern (if needed)
- [ ] Workflow file created with required_reading, process, success_criteria
- [ ] SKILL.md intake updated with new option
- [ ] SKILL.md routing updated
- [ ] SKILL.md workflows_index updated
- [ ] Any needed knowledge files created
- [ ] Tested and working
</success_criteria>
