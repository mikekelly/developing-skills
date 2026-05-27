# Workflow: Audit a Skill

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/recommended-structure.md
2. knowledge/skill-structure.md
3. knowledge/use-xml-tags.md
4. knowledge/be-clear-and-direct.md
5. knowledge/llm-wiki-principles.md
6. knowledge/skill-checklist.md
</required_reading>

<escalation_triggers>
Stop and ask when:
- Skill has more than 20 files (scope too large for single audit)
- YAML frontmatter cannot be parsed (may be intentional format)
- Unsure if something is an issue vs. intentional style choice
- Skill uses patterns not covered in knowledge materials
</escalation_triggers>

<process>
## Step 1: List Available Skills

Ask directly in chat instead of using a constrained-choice UI; there may be many skills.

Enumerate skills in chat as numbered list:
```bash
ls {skills-directory}/
```

Present as:
```
Available skills:
1. developing-agent-skills
2. building-macos-apps
3. managing-stripe
...
```

Ask: "Which skill would you like to audit? (enter number or name)"

## Step 2: Read the Skill

After user selects, read the full skill structure:
```bash
# Read main file
cat {skills-directory}/{skill-name}/SKILL.md

# Check for workflows and knowledge
ls {skills-directory}/{skill-name}/
ls {skills-directory}/{skill-name}/workflows/ 2>/dev/null
ls {skills-directory}/{skill-name}/knowledge/ 2>/dev/null
```

## Step 3: Run Audit Checklist

Evaluate against each criterion:

### YAML Frontmatter (Critical - #1 cause of skill failure)
- [ ] Has `name:` field (lowercase-with-hyphens, gerund form preferred)
- [ ] Name matches directory name exactly
- [ ] Has `description:` field (max 1024 chars)
- [ ] Description is wrapped in double quotes (prevents YAML parsing errors from colons/special chars)
- [ ] Description says what it does AND when to use it
- [ ] Description addresses agent as you (not "I can help" - avoid first person)
- [ ] Description covers ALL activities the skill handles (create/build, review/assess/check, audit/evaluate, update/modify/improve)
- [ ] Description uses proactive language if skill should auto-invoke ("MUST be loaded before...", "Use PROACTIVELY...")
- [ ] Description avoids passive/advisory language ("Expert guidance for..." sounds optional)
- [ ] Description includes synonyms users might use for the same request

### Structure
- [ ] SKILL.md targets under 500 lines
- [ ] Pure XML structure (no markdown headings # in body)
- [ ] All XML tags properly closed
- [ ] Has required tags: objective (or essential_principles for router), quick_start (or intake for router), success_criteria
- [ ] Knowledge files are one level deep (no chains: SKILL.md → ref.md → detail.md)
- [ ] `knowledge/` has top-level entry points and is used as compiled knowledge, not raw source storage

### Router Pattern (if complex skill)
- [ ] Essential principles inline in SKILL.md (not in separate file)
- [ ] Has intake question
- [ ] Has routing table
- [ ] All referenced workflow files exist
- [ ] All referenced knowledge files exist

### Workflows (if present)
- [ ] Each has required_reading section
- [ ] Each has process section
- [ ] Each has success_criteria section
- [ ] Required reading knowledge files exist

### Content Quality
- [ ] Principles are actionable (not vague platitudes like "be careful" or "handle appropriately")
- [ ] Steps are specific with concrete actions (not "process the data" → "extract email from column B, validate format, save to JSON")
- [ ] Success criteria are verifiable and testable (not "user is satisfied" → "output file exists and passes validation")
- [ ] No redundant content across files
- [ ] Knowledge files are maintained for contradictions, stale claims, and unreachable topic clusters
- [ ] Edge cases defined (what happens when input is empty, malformed, missing?)
- [ ] Ambiguous language avoided (no "try to", "should probably", "generally" without explicit exceptions)
- [ ] Examples shown, not just described (especially for output formats)
- [ ] Decision criteria provided when the agent must make choices
- [ ] No accumulated emphasis (multiple IMPORTANT/CRITICAL/MUST markers suggest iterative "prompting harder" instead of holistic design)
- [ ] Skill behavior does not surprise the user given its name and description
- [ ] Skill does not enable unauthorized access, credential exposure, data exfiltration, or other harmful behavior

### Evaluation and Trigger Testing
- [ ] At least 2-3 realistic evaluation prompts exist for important or reusable skills
- [ ] Expected behavior is observable, not just "quality is good"
- [ ] Should-trigger and should-not-trigger examples exist when discovery matters
- [ ] Near-miss trigger prompts cover adjacent tasks that should not load the skill
- [ ] Baseline comparison is defined when the user asks whether the skill improved behavior
- [ ] Evaluation findings led to generalized skill changes, not prompt-specific overfitting
- [ ] Subjective or user-facing eval outputs are reviewed with the user before major revision

## Step 4: Generate Report

Present findings as:

```
## Audit Report: {skill-name}

### ✅ Passing
- [list passing items]

### ⚠️ Issues Found
1. **[Issue name]**: [Description]
   → Fix: [Specific action]

2. **[Issue name]**: [Description]
   → Fix: [Specific action]

### 📊 Score: X/Y criteria passing
```

## Step 5: Offer Fixes

If issues found, ask:
"Would you like me to fix these issues?"

Options:
1. **Fix all** - Apply all recommended fixes
2. **Fix one by one** - Review each fix before applying
3. **Just the report** - No changes needed

If fixing:
- Make each change
- Verify file validity after each change
- Report what was fixed
</process>

<audit_anti_patterns>
## Common Anti-Patterns to Flag

**Skippable principles**: Essential principles in separate file instead of inline
**Monolithic skill**: Single file far over 500 lines without progressive disclosure
**Mixed concerns**: Procedures and knowledge in same file
**Vague steps**: "Handle the error appropriately"
**Untestable criteria**: "User is satisfied"
**Markdown headings in body**: Using # instead of XML tags
**Missing routing**: Complex skill without intake/routing
**Broken links**: Files mentioned but don't exist
**Redundant content**: Same information in multiple places
**Accumulated emphasis**: Multiple IMPORTANT/CRITICAL markers competing for attention—sign of iterative "prompting harder" instead of holistic review
</audit_anti_patterns>

<success_criteria>
Audit is complete when:
- [ ] Skill fully read and analyzed
- [ ] All checklist items evaluated
- [ ] Report presented to user
- [ ] Fixes applied (if requested)
- [ ] User has clear picture of skill health
</success_criteria>
