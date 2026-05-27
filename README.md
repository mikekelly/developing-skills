# developing-skills

Skill-development guidance for creating, auditing, evaluating, and maintaining agent skills.

This skill is itself a standalone skill repo. Its `SKILL.md` is the router, `workflows/` contains executable procedures, `knowledge/` contains compiled guidance, `templates/` contains reusable output structures, and `evals/` contains skill-specific behavior and trigger checks.

## Install

Place this directory where your agent runtime discovers skills, for example:

```bash
ln -s /path/to/developing-skills ~/.agents/skills/developing-skills
```

The final directory basename should match the frontmatter name: `developing-skills`.

## Validate

Run the repo validator before publishing changes:

```bash
ruby scripts/validate-repo.rb
```

For content changes, run `workflows/audit-skill.md` against this repo and compare behavior with `evals/behavior.json` and `evals/triggers.json`.
