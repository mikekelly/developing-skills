# Recommended Skill Structure

The optimal structure for complex skills separates routing, workflows, and knowledge.

<structure>
```
skill-name/
├── SKILL.md              # Router + essential principles (unavoidable)
├── workflows/            # Step-by-step procedures (how)
│   ├── workflow-a.md
│   ├── workflow-b.md
│   └── ...
└── knowledge/            # Compiled domain knowledge (what)
    ├── topic-a.md
    ├── topic-b.md
    └── ...
```
</structure>

<why_this_works>
## Problems This Solves

**Problem 1: Context gets skipped**
When important principles are in a separate file, the agent may not read them.
**Solution:** Put essential principles directly in SKILL.md. They load automatically.

**Problem 2: Wrong context loaded**
A "build" task loads debugging knowledge files. A "debug" task loads build knowledge files.
**Solution:** Intake question determines intent → routes to specific workflow → workflow specifies which knowledge files to read.

**Problem 3: Monolithic skills are overwhelming**
500+ lines of mixed content makes it hard to find relevant parts.
**Solution:** Small router (SKILL.md) + focused workflows + knowledge library.

**Problem 4: Procedures mixed with knowledge**
"How to do X" mixed with "What X means" creates confusion.
**Solution:** Workflows are procedures (steps). Knowledge files are durable compiled knowledge (patterns, examples).
</why_this_works>

<llm_wiki_mapping>
This structure is the skill-specific form of the LLM Wiki pattern:

- `SKILL.md` is the schema and entry map: it defines conventions, routing, and `knowledge_index`.
- `workflows/` are the operations: they decide which knowledge files to load and how to act.
- `knowledge/` is the maintained wiki layer: synthesized Markdown pages that compound over time.

Keep raw source material outside `knowledge/` unless it has been reduced into reusable guidance. When knowledge changes, update the relevant page and any entry points, cross-links, or workflows needed to keep the corpus traversable.
</llm_wiki_mapping>

<skill_md_template>
SKILL.md template:

```markdown
---
name: skill-name
description: "What it does and when to use it."
---

<essential_principles>
<core_concept>
[Brief concept that anchors the skill]
</core_concept>

<principle name="[name]">
[Brief explanation]
</principle>

<principle name="[name]">
[Brief explanation]
</principle>
</essential_principles>

<intake>
**Ask the user:**

What would you like to do?
1. [Option A]
2. [Option B]
3. [Option C]
4. Something else

**Wait for response before proceeding.**
</intake>

<routing>

| Option | Keywords | Workflow |
|--------|----------|----------|
| 1 | keyword / keyword | `workflows/option-a.md` |
| 2 | keyword / keyword | `workflows/option-b.md` |
| 3 | keyword / keyword | `workflows/option-c.md` |
| 4 | other | Clarify, then select |

**After reading the workflow, follow it exactly.**
</routing>

<knowledge_index>
All domain knowledge in `knowledge/`:

**Category A:** file-a.md, file-b.md
**Category B:** file-c.md, file-d.md
</knowledge_index>

<workflows_index>

| Workflow | Purpose |
|----------|---------|
| option-a.md | [What it does] |
| option-b.md | [What it does] |
| option-c.md | [What it does] |

</workflows_index>
```
</skill_md_template>

<workflow_template>
Workflow template:

```markdown
# Workflow: [Name]

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/relevant-file.md
2. knowledge/another-file.md
</required_reading>

<process>
## Step 1: [Name]
[What to do]

## Step 2: [Name]
[What to do]

## Step 3: [Name]
[What to do]
</process>

<success_criteria>
This workflow is complete when:
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3
</success_criteria>
```
</workflow_template>

<when_to_use_this_pattern>
## When to Use This Pattern

**Use router + workflows + knowledge when:**
- Multiple distinct workflows (build vs debug vs ship)
- Different workflows need different knowledge files
- Essential principles must not be skipped
- Skill has grown beyond 200 lines

**Use simple single-file skill when:**
- One workflow
- Small knowledge set
- Under 200 lines total
- No essential principles to enforce
</when_to_use_this_pattern>

<key_insight>
## The Key Insight

**SKILL.md is always loaded. Use this guarantee.**

Put unavoidable content in SKILL.md:
- Essential principles
- Intake question
- Routing logic

Put workflow-specific content in workflows/:
- Step-by-step procedures
- Required knowledge files for that workflow
- Success criteria for that workflow

Put reusable knowledge in knowledge/:
- Patterns and examples
- Technical details
- Domain expertise
- Durable synthesis compiled from source material or repeated practice
</key_insight>
