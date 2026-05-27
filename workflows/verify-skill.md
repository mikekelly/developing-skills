# Workflow: Verify Skill Content Accuracy

<required_reading>
**Read these knowledge files NOW:**
1. knowledge/skill-structure.md
2. knowledge/llm-wiki-principles.md
</required_reading>

<purpose>
Audit checks structure. **Verify checks truth.**

Skills contain claims about external things: APIs, CLI tools, frameworks, services. These change over time. This workflow checks if a skill's content is still accurate.
</purpose>

<process>
## Step 1: Resolve Target Skill

If the user already named a skill, provided a path, or the current working directory is clearly a skill repo, use it. Do not list every available skill when the target is already clear.

Only when the target is unclear, list candidates:

```bash
ls {skills-directory}/
```

Present numbered list, ask: "Which skill should I verify for accuracy?"

## Step 2: Read and Categorize

Read the entire skill (SKILL.md + workflows/ + knowledge/):
```bash
cat {skills-directory}/{skill-name}/SKILL.md
cat {skills-directory}/{skill-name}/workflows/*.md 2>/dev/null
cat {skills-directory}/{skill-name}/knowledge/*.md 2>/dev/null
```

Categorize by primary dependency type:

| Type | Examples | Verification Method |
|------|----------|---------------------|
| **API/Service** | managing-stripe, managing-gohighlevel | Official docs, SDK docs, changelog, status page |
| **CLI Tools** | building-macos-apps (xcodebuild, swift) | Run commands |
| **Framework** | building-iphone-apps (SwiftUI, UIKit) | Official docs, release notes, repository examples |
| **Integration** | setting-up-stripe-payments | Official integration guides and changelogs |
| **Pure Process** | developing-agent-skills | No external deps |

Report: "This skill is primarily [type]-based. I'll verify using [method]."

## Step 3: Extract Verifiable Claims

Scan skill content and extract:

**CLI Tools mentioned:**
- Tool names (xcodebuild, swift, npm, etc.)
- Specific flags/options documented
- Expected output patterns

**API Endpoints:**
- Service names (Stripe, Meta, etc.)
- Specific endpoints documented
- Authentication methods
- SDK versions

**Framework Patterns:**
- Framework names (SwiftUI, React, etc.)
- Specific APIs/patterns documented
- Version-specific features

**File Paths/Structures:**
- Expected project structures
- Config file locations

**Knowledge maintenance:**
- Stale claims inside `knowledge/`
- Contradictions between knowledge files
- Raw dumps that should be compiled into durable guidance
- Unreachable knowledge pages not connected through entry-point pages, workflow required_reading, or links from related pages

Present: "Found X verifiable claims to check."

## Step 4: Verify by Type

### For CLI Tools
```bash
# Check tool exists
which {tool-name}

# Check version
{tool-name} --version

# Verify documented flags work
{tool-name} --help | grep "{documented-flag}"
```

### For API/Service Skills
Use available documentation or browsing tools to fetch current official documentation, SDK references, changelogs, and status pages.

Compare skill's documented patterns against current docs:
- Are endpoints still valid?
- Has authentication changed?
- Are there deprecated methods being used?

### For Framework Skills
Use available documentation or browsing tools to check current official docs, release notes, and repository examples.

Check:
- Are documented APIs still current?
- Have patterns changed?
- Are there newer recommended approaches?

### For Integration Skills
Check official integration guides, SDK docs, changelogs, migration guides, and deprecation notices. Search current docs for breaking changes and recommended patterns.

### For Services with Status Pages
Check official docs, changelogs, and status pages if available.

## Step 5: Generate Freshness Report

Present findings:

```
## Verification Report: {skill-name}

### ✅ Verified Current
- [Claim]: [Evidence it's still accurate]

### ⚠️ May Be Outdated
- [Claim]: [What changed / newer info found]
  → Current: [what docs now say]

### ❌ Broken / Invalid
- [Claim]: [Why it's wrong]
  → Fix: [What it should be]

### ℹ️ Could Not Verify
- [Claim]: [Why verification wasn't possible]

---
**Overall Status:** [Fresh / Needs Updates / Significantly Stale]
**Last Verified:** [Today's date]
```

## Step 6: Offer Updates

If issues found:

"Found [N] items that need updating. Would you like me to:"

1. **Update all** - Apply all corrections
2. **Review each** - Show each change before applying
3. **Just the report** - No changes

If updating:
- Make changes based on verified current information
- Add verification date comment if appropriate
- Update `knowledge_index`, workflow required_reading, or related knowledge links if the correction changes how the compiled knowledge layer is traversed
- Report what was updated

## Step 7: Suggest Verification Schedule

Based on skill type, recommend:

| Skill Type | Recommended Frequency |
|------------|----------------------|
| API/Service | Every 1-2 months |
| Framework | Every 3-6 months |
| CLI Tools | Every 6 months |
| Pure Process | Annually |

"This skill should be re-verified in approximately [timeframe]."
</process>

<verification_shortcuts>
## Quick Verification Commands

**Check if CLI tool exists and get version:**
```bash
which {tool} && {tool} --version
```

**Documentation lookup patterns:**
- Official docs: "{service or framework} official docs {feature}"
- Breaking changes: "{service or framework} breaking changes"
- Deprecations: "{service or framework} deprecated API"
- Migration guides: "{service or framework} migration guide"
</verification_shortcuts>

<success_criteria>
Verification is complete when:
- [ ] Skill categorized by dependency type
- [ ] Verifiable claims extracted
- [ ] Each claim checked with appropriate method
- [ ] Freshness report generated
- [ ] Updates applied (if requested)
- [ ] User knows when to re-verify
</success_criteria>
