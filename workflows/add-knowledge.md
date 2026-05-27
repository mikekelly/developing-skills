# Workflow: Add Knowledge to Existing Skill

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/recommended-structure.md
2. knowledge/skill-structure.md
3. knowledge/llm-wiki-principles.md
</required_reading>

<process>
## Step 1: Resolve Target Skill

If the user already named a skill, provided a path, or the current working directory is clearly a skill repo, use it. Do not list every available skill when the target is already clear.

Only when the target is unclear, list candidates:

```bash
ls {skills-directory}/
```

Present numbered list, ask: "Which skill needs a new knowledge file?"

## Step 2: Analyze Current Structure

```bash
cat {skills-directory}/{skill-name}/SKILL.md
ls {skills-directory}/{skill-name}/knowledge/ 2>/dev/null
```

Determine:
- **Has knowledge/ folder?** → Good, can add directly
- **Simple skill?** → May need to create knowledge/ first
- **What knowledge files exist?** → Understand the knowledge landscape

Report current knowledge files to user.

## Step 3: Gather Knowledge Requirements

Ask:
- What knowledge should this knowledge file contain?
- Which workflows will use it?
- Is this reusable across workflows or specific to one?
- What source material or prior answer is this compiling?

**If specific to one workflow** → Consider putting it inline in that workflow instead.

## Step 4: Create the Knowledge File

Create `knowledge/{topic-name}.md`:

Use semantic XML tags to structure the content:
```xml
<overview>
Brief description of what this knowledge file covers
</overview>

<patterns>
## Common Patterns
[Reusable patterns, examples, code snippets]
</patterns>

<guidelines>
## Guidelines
[Best practices, rules, constraints]
</guidelines>

<examples>
## Examples
[Concrete examples with explanation]
</examples>
```

Keep the file LLM Wiki-style: synthesize reusable guidance, keep raw sources out of `knowledge/`, link related knowledge files when useful, and make the file discoverable through an entry-point page, workflow `required_reading`, or links from related pages.

## Step 5: Update SKILL.md

If the new knowledge file is a top-level entry point, add it to `<knowledge_index>`:
```markdown
**Category:** existing.md, new-topic.md
```

If it is a supporting page, link to it from the relevant knowledge file or workflow instead of listing every page in SKILL.md.

## Step 6: Update Workflows That Need It

For each workflow that should use this knowledge file:

1. Read the workflow file
2. Add to its `<required_reading>` section
3. Verify the workflow still makes sense with this addition

## Step 7: Verify

- [ ] Knowledge file exists and is well-structured
- [ ] Knowledge file is discoverable through an entry-point page, workflow required_reading, or related-page links
- [ ] Relevant workflows have it in required_reading
- [ ] Content is synthesized from source material, not a raw dump
- [ ] No broken knowledge links
</process>

<success_criteria>
Knowledge addition is complete when:
- [ ] Knowledge file created with useful content
- [ ] Added to knowledge_index as an entry point, workflow required_reading, or related-page links as appropriate
- [ ] Relevant workflows updated to read it
- [ ] Content is reusable (not workflow-specific)
</success_criteria>
