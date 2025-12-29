<overview>
Skills have three structural components: YAML frontmatter (metadata), pure XML body structure (content organization), and progressive disclosure (file organization). This reference defines requirements and best practices for each component.
</overview>

<xml_structure_requirements>
<critical_rule>
**Remove ALL markdown headings (#, ##, ###) from skill body content.** Replace with semantic XML tags. Keep markdown formatting WITHIN content (bold, italic, lists, code blocks, links).
</critical_rule>

<required_tags>
Every skill MUST have these three tags:

- **`<objective>`** - What the skill does and why it matters (1-3 paragraphs)
- **`<quick_start>`** - Immediate, actionable guidance (minimal working example)
- **`<success_criteria>`** or **`<when_successful>`** - How to know it worked
</required_tags>

<conditional_tags>
Add based on skill complexity and domain requirements:

- **`<context>`** - Background/situational information
- **`<workflow>` or `<process>`** - Step-by-step procedures
- **`<advanced_features>`** - Deep-dive topics (progressive disclosure)
- **`<validation>`** - How to verify outputs
- **`<examples>`** - Multi-shot learning
- **`<anti_patterns>`** - Common mistakes to avoid
- **`<security_checklist>`** - Non-negotiable security patterns
- **`<testing>`** - Testing workflows
- **`<common_patterns>`** - Code examples and recipes
- **`<reference_guides>` or `<detailed_references>`** - Links to reference files

See [use-xml-tags.md](use-xml-tags.md) for detailed guidance on each tag.
</conditional_tags>

<tag_selection_intelligence>
**Simple skills** (single domain, straightforward):
- Required tags only
- Example: Text extraction, file format conversion

**Medium skills** (multiple patterns, some complexity):
- Required tags + workflow/examples as needed
- Example: Document processing with steps, API integration

**Complex skills** (multiple domains, security, APIs):
- Required tags + conditional tags as appropriate
- Example: Payment processing, authentication systems, multi-step workflows
</tag_selection_intelligence>

<xml_nesting>
Properly nest XML tags for hierarchical content:

```xml
<examples>
<example number="1">
<input>User input</input>
<output>Expected output</output>
</example>
</examples>
```

Always close tags:
```xml
<objective>
Content here
</objective>
```
</xml_nesting>

<tag_naming_conventions>
Use descriptive, semantic names:
- `<workflow>` not `<steps>`
- `<success_criteria>` not `<done>`
- `<anti_patterns>` not `<dont_do>`

Be consistent within your skill. If you use `<workflow>`, don't also use `<process>` for the same purpose (unless they serve different roles).
</tag_naming_conventions>
</xml_structure_requirements>

<yaml_requirements>
<invocation_optimization>
**Name and description are discovery mechanisms**

The name and description are not just metadata — they are the PRIMARY mechanism by which Claude decides whether to use a skill. When a user makes a request, Claude scans available skills and matches against their names and descriptions.

**Goal**: Maximize the probability Claude will invoke the skill for every relevant task.

This means optimizing for:
1. **Recognition** — Claude must recognize that the skill applies to the current task
2. **Confidence** — Claude must feel confident the skill is the right tool (not just possibly relevant)
3. **Timing** — Claude must invoke the skill at the right moment (before starting, not mid-task)

**Common failure modes:**
- Vague descriptions → Claude doesn't recognize relevance
- Passive/advisory language → Claude treats skill as optional reference
- Wrong verb scope → Claude doesn't invoke for review/update tasks if name says "create"
- No trigger signals → Claude waits for explicit user request instead of invoking proactively

**Think of it as prompt engineering for skill selection.** The name and description are a prompt that must convince Claude to use the skill. Apply the same rigor you would to any critical prompt.
</invocation_optimization>

<required_fields>
```yaml
---
name: skill-name-here
description: What it does and when to use it (third person, specific triggers)
---
```
</required_fields>

<name_field>
**Validation rules**:
- Maximum 64 characters
- Lowercase letters, numbers, hyphens only
- No XML tags
- No reserved words: "anthropic", "claude"
- Must match directory name exactly

**Examples**:
- ✅ `process-pdfs`
- ✅ `manage-facebook-ads`
- ✅ `setup-stripe-payments`
- ❌ `PDF_Processor` (uppercase)
- ❌ `helper` (vague)
- ❌ `claude-helper` (reserved word)
</name_field>

<description_field>
**Validation rules**:
- Non-empty, maximum 1024 characters
- No XML tags
- Third person (never first or second person)
- Include what it does AND when to use it

**Critical rule**: Always write in third person.
- ✅ "Processes Excel files and generates reports"
- ❌ "I can help you process Excel files"
- ❌ "You can use this to process Excel files"

**Structure**: Include both capabilities and triggers.

**Effective examples**:
```yaml
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

```yaml
description: Analyze Excel spreadsheets, create pivot tables, generate charts. Use when analyzing Excel files, spreadsheets, tabular data, or .xlsx files.
```

```yaml
description: Generate descriptive commit messages by analyzing git diffs. Use when the user asks for help writing commit messages or reviewing staged changes.
```

**Avoid**:
```yaml
description: Helps with documents
```

```yaml
description: Processes data
```

<proactive_invocation>
**Proactive vs Reactive Descriptions**

Descriptions control when Claude invokes a skill. Match your description to intended usage:

**Reactive (wait for explicit request or mid-task):**
```yaml
description: Expert guidance for X. Use when working with X files.
```
- Claude waits for user to mention skill or already be working on X
- Appropriate for reference/consultation skills

**Proactive (invoke before starting work):**
```yaml
description: Use PROACTIVELY when creating X. MUST be invoked before writing any new X.
```
- Claude invokes the skill automatically when task matches
- Appropriate for skills that should guide the process from the start

**Key elements for proactive descriptions:**
- Use "PROACTIVELY" or "MUST BE USED" explicitly
- Specify trigger point: "before writing", "when starting to", "before beginning"
- Lead with action verb: "Use...", "Invoke..."
- Avoid passive/advisory language: "Expert guidance for..." sounds optional

**Examples:**
- ❌ "Expert guidance for creating skills. Use when working with SKILL.md files."
- ✅ "Use PROACTIVELY when creating, reviewing, or updating Skills. MUST be invoked before writing any new skill."

- ❌ "Helps with commit messages. Use when committing code."
- ✅ "Use PROACTIVELY to generate commit messages. Invoke before running git commit."

- ❌ "Code review assistance for pull requests."
- ✅ "Use PROACTIVELY after writing code. MUST be invoked to review changes before committing."
</proactive_invocation>
</description_field>
</yaml_requirements>

<naming_conventions>
Use **verb-noun convention** for skill names:

<pattern name="manage">
Managing external services or resources

Examples: `manage-facebook-ads`, `manage-zoom`, `manage-stripe`, `manage-supabase`
</pattern>

<pattern name="setup">
Configuration/integration tasks

Examples: `setup-stripe-payments`, `setup-meta-tracking`
</pattern>

<pattern name="generate">
Generation tasks

Examples: `generate-ai-images`
</pattern>

<pattern name="develop">
Full lifecycle development (create + review + update + iterate)

Examples: `develop-agent-skill`, `develop-mcp-server`, `develop-hook`

Use for any skill that builds artifacts that may need revision or iteration.
</pattern>

<pattern name="process">
Transformation and data processing

Examples: `process-pdf`, `process-images`, `process-csv`
</pattern>

<avoid_patterns>
- Vague: `helper`, `utils`, `tools`
- Generic: `documents`, `data`, `files`
- Reserved words: `anthropic-helper`, `claude-tools`
- Inconsistent: Directory `facebook-ads` but name `facebook-ads-manager`
</avoid_patterns>

<verb_selection>
**Choosing the Right Verb**

The verb should match the skill's actual scope:

| Verb | Scope | Use When |
|------|-------|----------|
| `develop-*` | Full lifecycle | Builds artifacts that may need revision (create + review + update) |
| `generate-*` | One-shot output | Produces output from input, no iteration expected |
| `manage-*` | CRUD + ongoing | External resources, services, ongoing operations |
| `setup-*` | One-time config | Initial setup, integration, configuration |
| `process-*` | Transformation | Converting, extracting, transforming data |

**Key distinction**: Use `generate-*` for one-shot outputs (images, commit messages). Use `develop-*` when the artifact may need iteration (skills, hooks, servers).

**Examples:**
- Skill builds hooks that may need debugging → `develop-hook`
- Skill produces images from prompts → `generate-image`
- Skill sets up Stripe integration once → `setup-stripe`
- Skill manages ongoing Stripe operations → `manage-stripe`
</verb_selection>

<singular_vs_plural>
**Singular vs Plural Nouns**

Match the noun to the operational unit:

**Use singular when:**
- Skill operates on one item at a time
- Skill represents expertise in a domain concept
- Example: `develop-agent-skill` — you develop one skill at a time

**Use plural when:**
- Skill operates on collections or batches
- Skill manages multiple instances simultaneously
- Example: `manage-facebook-ads` — you manage multiple ads

**Test**: Ask "what does one invocation operate on?" If the answer is "one skill" or "one hook", use singular.

**Examples:**
- ✅ `develop-agent-skill` — each invocation develops one skill
- ✅ `manage-facebook-ads` — each invocation can manage multiple ads
- ✅ `process-images` — batch processing multiple images
- ✅ `generate-commit-message` — generates one message at a time
- ❌ `develop-hooks` when it develops one hook at a time → use `develop-hook`
</singular_vs_plural>
</naming_conventions>

<progressive_disclosure>
<principle>
SKILL.md serves as an overview that points to detailed materials as needed. This keeps context window usage efficient.
</principle>

<practical_guidance>
- Keep SKILL.md body under 500 lines
- Split content into separate files when approaching this limit
- Keep references one level deep from SKILL.md
- Add table of contents to reference files over 100 lines
</practical_guidance>

<pattern name="high_level_guide">
Quick start in SKILL.md, details in reference files:

```markdown
---
name: pdf-processing
description: Extracts text and tables from PDF files, fills forms, and merges documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
---

<objective>
Extract text and tables from PDF files, fill forms, and merge documents using Python libraries.
</objective>

<quick_start>
Extract text with pdfplumber:

```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
</quick_start>

<advanced_features>
**Form filling**: See [forms.md](forms.md)
**API reference**: See [reference.md](reference.md)
</advanced_features>
```

Claude loads forms.md or reference.md only when needed.
</pattern>

<pattern name="domain_organization">
For skills with multiple domains, organize by domain to avoid loading irrelevant context:

```
bigquery-skill/
├── SKILL.md (overview and navigation)
└── reference/
    ├── finance.md (revenue, billing metrics)
    ├── sales.md (opportunities, pipeline)
    ├── product.md (API usage, features)
    └── marketing.md (campaigns, attribution)
```

When user asks about revenue, Claude reads only finance.md. Other files stay on filesystem consuming zero tokens.
</pattern>

<pattern name="conditional_details">
Show basic content in SKILL.md, link to advanced in reference files:

```xml
<objective>
Process DOCX files with creation and editing capabilities.
</objective>

<quick_start>
<creating_documents>
Use docx-js for new documents. See [docx-js.md](docx-js.md).
</creating_documents>

<editing_documents>
For simple edits, modify XML directly.

**For tracked changes**: See [redlining.md](redlining.md)
**For OOXML details**: See [ooxml.md](ooxml.md)
</editing_documents>
</quick_start>
```

Claude reads redlining.md or ooxml.md only when the user needs those features.
</pattern>

<critical_rules>
**Keep references one level deep**: All reference files should link directly from SKILL.md. Avoid nested references (SKILL.md → advanced.md → details.md) as Claude may only partially read deeply nested files.

**Add table of contents to long files**: For reference files over 100 lines, include a table of contents at the top.

**Use pure XML in reference files**: Reference files should also use pure XML structure (no markdown headings in body).
</critical_rules>
</progressive_disclosure>

<file_organization>
<filesystem_navigation>
Claude navigates your skill directory using bash commands:

- Use forward slashes: `reference/guide.md` (not `reference\guide.md`)
- Name files descriptively: `form_validation_rules.md` (not `doc2.md`)
- Organize by domain: `reference/finance.md`, `reference/sales.md`
</filesystem_navigation>

<directory_structure>
Typical skill structure:

```
skill-name/
├── SKILL.md (main entry point, pure XML structure)
├── references/ (optional, for progressive disclosure)
│   ├── guide-1.md (pure XML structure)
│   ├── guide-2.md (pure XML structure)
│   └── examples.md (pure XML structure)
└── scripts/ (optional, for utility scripts)
    ├── validate.py
    └── process.py
```
</directory_structure>
</file_organization>

<anti_patterns>
<pitfall name="markdown_headings_in_body">
❌ Do NOT use markdown headings in skill body:

```markdown
# PDF Processing

## Quick start
Extract text...

## Advanced features
Form filling...
```

✅ Use pure XML structure:

```xml
<objective>
PDF processing with text extraction, form filling, and merging.
</objective>

<quick_start>
Extract text...
</quick_start>

<advanced_features>
Form filling...
</advanced_features>
```
</pitfall>

<pitfall name="vague_descriptions">
- ❌ "Helps with documents"
- ✅ "Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction."
</pitfall>

<pitfall name="inconsistent_pov">
- ❌ "I can help you process Excel files"
- ✅ "Processes Excel files and generates reports"
</pitfall>

<pitfall name="wrong_naming_convention">
- ❌ Directory: `facebook-ads`, Name: `facebook-ads-manager`
- ✅ Directory: `manage-facebook-ads`, Name: `manage-facebook-ads`
- ❌ Directory: `stripe-integration`, Name: `stripe`
- ✅ Directory: `setup-stripe-payments`, Name: `setup-stripe-payments`
</pitfall>

<pitfall name="deeply_nested_references">
Keep references one level deep from SKILL.md. Claude may only partially read nested files (SKILL.md → advanced.md → details.md).
</pitfall>

<pitfall name="windows_paths">
Always use forward slashes: `scripts/helper.py` (not `scripts\helper.py`)
</pitfall>

<pitfall name="missing_required_tags">
Every skill must have: `<objective>`, `<quick_start>`, and `<success_criteria>` (or `<when_successful>`).
</pitfall>
</anti_patterns>

<validation_checklist>
Before finalizing a skill, verify:

- ✅ YAML frontmatter valid (name matches directory, description in third person)
- ✅ No markdown headings in body (pure XML structure)
- ✅ Required tags present: objective, quick_start, success_criteria
- ✅ Conditional tags appropriate for complexity level
- ✅ All XML tags properly closed
- ✅ Progressive disclosure applied (SKILL.md < 500 lines)
- ✅ Reference files use pure XML structure
- ✅ File paths use forward slashes
- ✅ Descriptive file names
</validation_checklist>
