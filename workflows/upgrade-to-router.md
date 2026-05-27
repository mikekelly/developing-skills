# Workflow: Upgrade Skill to Router Pattern

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/recommended-structure.md
2. knowledge/skill-structure.md
3. knowledge/llm-wiki-principles.md
</required_reading>

<process>
## Step 1: Select the Skill

```bash
ls {skills-directory}/
```

Present numbered list, ask: "Which skill should be upgraded to the router pattern?"

## Step 2: Verify It Needs Upgrading

Read the skill:
```bash
cat {skills-directory}/{skill-name}/SKILL.md
ls {skills-directory}/{skill-name}/
```

**Already a router?** (has workflows/ and intake question)
→ Tell user it's already using router pattern, offer to add workflows instead

**Simple skill that should stay simple?** (under 200 lines, single workflow)
→ Explain that router pattern may be overkill, ask if they want to proceed anyway

**Good candidate for upgrade:**
- Over 200 lines
- Multiple distinct use cases
- Essential principles that shouldn't be skipped
- Growing complexity

## Step 3: Identify Components

Analyze the current skill and identify:

1. **Essential principles** - Rules that apply to ALL use cases
2. **Distinct workflows** - Different things a user might want to do
3. **Reusable knowledge** - Patterns, examples, technical details

Present findings:
```
## Analysis

**Essential principles I found:**
- [Principle 1]
- [Principle 2]

**Distinct workflows I identified:**
- [Workflow A]: [description]
- [Workflow B]: [description]

**Knowledge that could become files:**
- [Knowledge topic 1]
- [Knowledge topic 2]
```

Ask: "Does this breakdown look right? Any adjustments?"

## Step 4: Create Directory Structure

```bash
mkdir -p {skills-directory}/{skill-name}/workflows
mkdir -p {skills-directory}/{skill-name}/knowledge
```

## Step 5: Extract Workflows

For each identified workflow:

1. Create `workflows/{workflow-name}.md`
2. Add required_reading section (knowledge files it needs)
3. Add process section (steps from original skill)
4. Add success_criteria section

## Step 6: Extract Knowledge Files

For each identified knowledge topic:

1. Create `knowledge/{topic-name}.md`
2. Move relevant content from original skill
3. Structure with semantic XML tags
4. Preserve LLM Wiki discipline: compile reusable guidance, connect it to the corpus, and avoid raw dumps

## Step 7: Rewrite SKILL.md as Router

Replace SKILL.md with router structure:

```markdown
---
name: {skill-name}
description: "{existing description}"
---

<essential_principles>
[Extracted principles - inline, cannot be skipped]
</essential_principles>

<intake>
**Ask the user:**

What would you like to do?
1. [Workflow A option]
2. [Workflow B option]
...

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "keywords" | `workflows/workflow-a.md` |
| 2, "keywords" | `workflows/workflow-b.md` |
</routing>

<knowledge_index>
[List all knowledge files by category]
</knowledge_index>

<workflows_index>
| Workflow | Purpose |
|----------|---------|
| workflow-a.md | [What it does] |
| workflow-b.md | [What it does] |
</workflows_index>
```

## Step 8: Verify Nothing Was Lost

Compare original skill content against new structure:
- [ ] All principles preserved (now inline)
- [ ] All procedures preserved (now in workflows)
- [ ] All knowledge preserved (now in knowledge/)
- [ ] Knowledge corpus has top-level entry points and traversable links
- [ ] No orphaned content

## Step 9: Test

Invoke the upgraded skill:
- Does intake question appear?
- Does each routing option work?
- Do workflows load correct knowledge files?
- Does behavior match original skill?

Report any issues.
</process>

<success_criteria>
Upgrade is complete when:
- [ ] workflows/ directory created with workflow files
- [ ] knowledge/ directory created (if needed)
- [ ] SKILL.md rewritten as router
- [ ] Essential principles inline in SKILL.md
- [ ] All original content preserved
- [ ] Intake question routes correctly
- [ ] Tested and working
</success_criteria>
