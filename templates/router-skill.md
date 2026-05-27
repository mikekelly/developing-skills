---
name: {{SKILL_NAME}}
description: "{{What it does}} Use when {{trigger conditions}}."
---

<essential_principles>
<core_concept>
{{Brief concept that anchors the skill}}
</core_concept>

<principle name="{{first-principle}}">
{{Explanation}}
</principle>

<principle name="{{second-principle}}">
{{Explanation}}
</principle>

<principle name="{{third-principle}}">
{{Explanation}}
</principle>
</essential_principles>

<intake>
**Ask the user:**

What would you like to do?
1. {{First option}}
2. {{Second option}}
3. {{Third option}}

**Wait for response before proceeding.**
</intake>

<routing>

| Option | Keywords | Workflow |
|--------|----------|----------|
| 1 | {{keywords}} | `workflows/{{first-workflow}}.md` |
| 2 | {{keywords}} | `workflows/{{second-workflow}}.md` |
| 3 | {{keywords}} | `workflows/{{third-workflow}}.md` |

**After reading the workflow, follow it exactly.**
</routing>

<escalation_triggers>
Stop and ask the user when:
- {{Scope threshold, e.g., "Task would affect more than X files"}}
- {{Ambiguity condition, e.g., "Multiple valid approaches and choice matters"}}
- {{Error condition, e.g., "Same error after 2 attempts"}}
- {{Uncertainty condition, e.g., "Confidence below 50%"}}
</escalation_triggers>

<quick_reference>
{{Brief information always useful to have visible}}
</quick_reference>

<knowledge_index>
All in `knowledge/`:
- {{topic-1.md}} - {{purpose}}
- {{topic-2.md}} - {{purpose}}
</knowledge_index>

<workflows_index>
All in `workflows/`:

| Workflow | Purpose |
|----------|---------|
| {{first-workflow}}.md | {{purpose}} |
| {{second-workflow}}.md | {{purpose}} |
| {{third-workflow}}.md | {{purpose}} |

</workflows_index>

<success_criteria>
A well-executed {{skill name}}:
- {{First criterion}}
- {{Second criterion}}
- {{Third criterion}}
</success_criteria>
