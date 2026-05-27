# Evaluation-Driven Skill Development

Build evaluations before writing extensive documentation. This keeps the skill focused on real agent failures instead of imagined needs.

<process>
## Step 1: Identify Gaps

Run a representative task without the skill. Document specific failures:
- What context was missing?
- What instructions were needed?
- Where did the agent make wrong assumptions?

## Step 2: Create Evaluation Scenarios

Build 3+ scenarios that test these gaps:

```json
{
  "skill": "skill-name",
  "query": "User request that exercises the skill",
  "files": ["test-files/example.txt"],
  "expected_behavior": [
    "Specific observable behavior 1",
    "Specific observable behavior 2",
    "Specific observable behavior 3"
  ]
}
```

## Step 3: Establish Baseline

Measure performance without the skill:
- What percentage of expected behaviors occur?
- What common failure patterns emerge?
- What does the agent waste time rediscovering?

## Step 4: Write Minimal Instructions

Create just enough content to address the gaps. Do not anticipate requirements that may never materialize.

## Step 5: Iterate

1. Run evaluations with skill loaded
2. Compare against baseline
3. Review subjective or user-facing outputs with the user
4. Refine based on actual failures, not assumptions
</process>

<agent_a_b_pattern>
## The Agent A/B Development Pattern

Work with one agent instance to create a skill that will be used by fresh instances later.

**Agent A** (designer):
- Helps design and refine instructions
- Reviews your work and suggests improvements
- Understands agent needs

**Agent B** (fresh executor):
- Starts without hidden context from the design conversation
- Tests the skill on real tasks
- Reveals gaps through actual usage

**Workflow:**
1. Complete a task with Agent A using normal prompting
2. Identify what context you repeatedly provided
3. Ask Agent A to create a skill capturing that pattern
4. Test with Agent B on related tasks
5. Observe Agent B's behavior and note failures
6. Return to Agent A with specifics: "Agent B forgot to X when asked for Y"
7. Refine and repeat
</agent_a_b_pattern>

<model_testing>
## Test Across Target Models

Skills act as additions to models, so effectiveness depends on the underlying model.

**Smaller/faster models:**
- Does the skill provide enough guidance?
- Are instructions explicit enough?
- Are examples complete?

**Balanced models:**
- Is the skill clear and efficient?
- Does it activate reliably?
- Does progressive disclosure work?

**Frontier/reasoning-heavy models:**
- Does the skill avoid over-explaining?
- Is there unnecessary hand-holding?
- Are constraints clear without reducing useful judgment?

What works perfectly for a frontier model might need more explicit structure for a smaller model.
</model_testing>

<observation_checklist>
## What to Observe During Testing

- **Unexpected exploration paths** - Does the agent read files in an order you didn't anticipate?
- **Missed connections** - Does the agent fail to follow links to important files?
- **Overreliance on sections** - Does the agent repeatedly read the same file?
- **Ignored content** - Does the agent never access a bundled file?

Iterate based on observations, not assumptions.
</observation_checklist>
