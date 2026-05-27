# Skill Quality Checklist

Use this checklist before sharing or publishing a skill.

<core_quality>
## Core Quality

- [ ] **Valid YAML frontmatter** - name and description fields present
- [ ] **Name matches directory** - lowercase-with-hyphens, gerund form preferred
- [ ] **Description is specific** - Says what it does AND when to use it (addresses agent as you)
- [ ] **SKILL.md targets under 500 lines** - Split into knowledge files if longer
- [ ] **XML-first structure** - `SKILL.md` uses XML tags as primary section boundaries, not markdown headings
- [ ] **Required tags present** - objective, quick_start/intake, success_criteria
- [ ] **All referenced files exist** - No broken links to workflow, knowledge, template, or eval files
- [ ] **XML tags properly closed** - Valid structure
</core_quality>

<content_quality>
## Content Quality

- [ ] **No time-sensitive information** - Or isolated in "old patterns" section
- [ ] **Consistent terminology** - One term per concept throughout
- [ ] **Examples are concrete** - Not abstract descriptions
- [ ] **Knowledge files one level deep** - No chains of knowledge files
- [ ] **LLM Wiki discipline followed** - `knowledge/` contains synthesized, traversable, maintained guidance rather than raw source dumps
- [ ] **Progressive disclosure used** - Details in separate files when appropriate
- [ ] **Workflows have clear steps** - Sequential, actionable
- [ ] **Concise** - Every token justifies its cost
- [ ] **No accumulated emphasis** - Holistic review done, duplicates removed, intent balanced
- [ ] **Lack of surprise** - Behavior matches the name and description
- [ ] **No harmful capability drift** - Does not enable unauthorized access, credential exposure, or data exfiltration
</content_quality>

<code_and_scripts>
## Code and Scripts (if applicable)

- [ ] **Scripts solve problems** - Don't punt errors to the agent
- [ ] **Error handling is explicit** - Helpful error messages
- [ ] **No magic constants** - All values documented/justified
- [ ] **Required packages listed** - Dependencies stated clearly
- [ ] **All forward slashes** - No Windows-style paths (use `path/to/file` not `path\to\file`)
- [ ] **MCP tools use full names** - `ServerName:tool_name` format
- [ ] **Validation steps included** - For critical operations
- [ ] **Feedback loops present** - For quality-critical tasks
</code_and_scripts>

<testing>
## Testing

- [ ] **At least three evaluation scenarios** - Real use cases
- [ ] **Trigger evals include near misses** - Should-trigger and should-not-trigger prompts are tested when discovery matters
- [ ] **Baseline selected when useful** - No skill, old skill, or previous iteration comparison for rigorous evals
- [ ] **Tested with target models** - Smaller, balanced, and/or frontier models as appropriate
- [ ] **Tested with real usage** - Not just imagined scenarios
- [ ] **Team feedback incorporated** - If applicable
- [ ] **Observed agent navigation** - Checked how it actually uses the skill
- [ ] **User-facing outputs reviewed** - Subjective outputs reviewed before major revision
</testing>

<agent_prompting>
## Agent Prompting

These elements ensure reliable autonomous behavior:

- [ ] **Classification before action** - `<intake>` forces categorization before proceeding
- [ ] **Phase gates with exit criteria** - Each phase has clear completion conditions
- [ ] **Concrete first action** - Step 1 is a specific command/action, not "analyze" or "consider"
- [ ] **Output format required** - Structure is mandatory, not suggested
- [ ] **Anti-patterns documented** - Common failure modes explicitly closed off (NEVER DO section)
- [ ] **Escalation triggers defined** - Explicit thresholds for when to stop and ask
</agent_prompting>

<standalone_skills>
## Standalone Skills (GitHub repos)

- [ ] **README.md included** - Installation instructions
- [ ] **Clear skill name** - Matches repo purpose
- [ ] **Installation options documented** - skill-manager, manual copy, etc.
- [ ] **LICENSE file present** - If distributing publicly
</standalone_skills>
