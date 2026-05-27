<overview>
Skills improve through iteration and testing. This knowledge file covers evaluation-driven development, fresh-agent testing patterns, and XML structure validation during testing.
</overview>

<evaluation_driven_development>
<principle>
Create evaluations BEFORE writing extensive documentation. This ensures your skill solves real problems rather than documenting imagined ones.
</principle>

<workflow>
<step_1>
**Identify gaps**: Run a representative task without the skill. Document specific failures or missing context.
</step_1>

<step_2>
**Create evaluations**: Build three scenarios that test these gaps.
</step_2>

<step_3>
**Establish baseline**: Measure performance without the skill.
</step_3>

<step_4>
**Write minimal instructions**: Create just enough content to address the gaps and pass evaluations.
</step_4>

<step_5>
**Iterate**: Execute evaluations, compare against baseline, and refine.
</step_5>
</workflow>

<evaluation_structure>
```json
{
  "skills": ["processing-pdfs"],
  "query": "Extract all text from this PDF file and save it to output.txt",
  "files": ["test-files/document.pdf"],
  "expected_behavior": [
    "Successfully reads the PDF file using appropriate library",
    "Extracts text content from all pages without missing any",
    "Saves extracted text to output.txt in clear, readable format"
  ]
}
```
</evaluation_structure>

<why_evaluations_first>
- Prevents documenting imagined problems
- Forces clarity about what success looks like
- Provides objective measurement of skill effectiveness
- Keeps skill focused on actual needs
- Enables quantitative improvement tracking
</why_evaluations_first>
</evaluation_driven_development>

<iterative_development_with_agents>
<principle>
The most effective skill development uses fresh agent contexts. Work with one agent context to design and refine the skill, then test with a separate context that lacks the design conversation.
</principle>

<creating_skills>
<workflow>
<step_1>
**Complete task without skill**: Work through the problem, noting what context you repeatedly provide.
</step_1>

<step_2>
**Draft skill from pattern**: Create a skill that captures the repeated context, workflow, decisions, and output expectations.
</step_2>

<step_3>
**Review for conciseness**: Remove unnecessary explanations.
</step_3>

<step_4>
**Improve architecture**: Organize content with progressive disclosure.
</step_4>

<step_5>
**Test with fresh context**: Use a fresh agent context to test on real tasks.
</step_5>

<step_6>
**Iterate based on observation**: Revise from specific issues observed in the fresh context.
</step_6>
</workflow>

<insight>
Fresh-context testing reveals which instructions are actually carried by the skill, rather than by hidden conversation history.
</insight>
</creating_skills>

<improving_skills>
<workflow>
<step_1>
**Use skill in real workflows**: Give a fresh context actual tasks.
</step_1>

<step_2>
**Observe behavior**: Where does it struggle, succeed, or make unexpected choices?
</step_2>

<step_3>
**Revise from evidence**: Share observations and current SKILL.md with the designing context.
</step_3>

<step_4>
**Review suggestions**: Consider reorganization, stronger language, or workflow restructuring.
</step_4>

<step_5>
**Apply and test**: Update skill and test again.
</step_5>

<step_6>
**Repeat**: Continue based on real usage, not assumptions.
</step_6>
</workflow>

<what_to_watch_for>
- **Unexpected exploration paths**: Structure might not be intuitive
- **Missed connections**: Links might need to be more explicit
- **Overreliance on sections**: Consider moving frequently-read content to main SKILL.md
- **Ignored content**: Poorly signaled or unnecessary files
- **Critical metadata**: The name and description in your skill's metadata are critical for discovery
</what_to_watch_for>
</improving_skills>
</iterative_development_with_agents>

<model_testing>
<principle>
Test with all models you plan to use. Different models have different strengths and need different levels of detail.
</principle>

<small_model_testing>
**Smaller/faster models**

Questions to ask:
- Does the skill provide enough guidance?
- Are examples clear and complete?
- Do implicit assumptions become explicit?
- Does the model need more structure?

Smaller models benefit from:
- More explicit instructions
- Complete examples (no partial code)
- Clear success criteria
- Step-by-step workflows
</small_model_testing>

<balanced_model_testing>
**Balanced models**

Questions to ask:
- Is the skill clear and efficient?
- Does it avoid over-explanation?
- Are workflows well-structured?
- Does progressive disclosure work?

Balanced models benefit from:
- Balanced detail level
- XML structure for clarity
- Progressive disclosure
- Concise but complete guidance
</balanced_model_testing>

<frontier_model_testing>
**Frontier/reasoning-heavy models**

Questions to ask:
- Does the skill avoid over-explaining?
- Can the model infer obvious steps?
- Are constraints clear?
- Is context minimal but sufficient?

Frontier models benefit from:
- Concise instructions
- Principles over procedures
- High degrees of freedom
- Trust in reasoning capabilities
</frontier_model_testing>

<balancing_across_models>
What works for a frontier model might need more detail for a smaller model. Aim for instructions that work well across all target models. Find the balance that serves your target audience.

See [core-principles.md](core-principles.md) for model testing examples.
</balancing_across_models>
</model_testing>

<xml_structure_validation>
<principle>
During testing, validate that your skill's XML structure is correct and complete.
</principle>

<validation_checklist>
After updating a skill, verify:

<required_tags_present>
- ✅ `<objective>` tag exists and defines what skill does
- ✅ `<quick_start>` tag exists with immediate guidance
- ✅ `<success_criteria>` or `<when_successful>` tag exists
</required_tags_present>

<no_markdown_headings>
- ✅ No `#`, `##`, or `###` headings as top-level `SKILL.md` body sections
- ✅ All major sections use XML tags
- ✅ Markdown formatting within tags is preserved (bold, italic, lists, code blocks)
</no_markdown_headings>

<proper_xml_nesting>
- ✅ All XML tags properly closed
- ✅ Nested tags have correct hierarchy
- ✅ No unclosed tags
</proper_xml_nesting>

<conditional_tags_appropriate>
- ✅ Conditional tags match skill complexity
- ✅ Simple skills use required tags only
- ✅ Complex skills add appropriate conditional tags
- ✅ No over-engineering or under-specifying
</conditional_tags_appropriate>

<knowledge_files_check>
- ✅ Knowledge files use XML section boundaries for major sections
- ✅ Links to knowledge files are correct
- ✅ Knowledge files are one level deep from SKILL.md
</knowledge_files_check>
</validation_checklist>

<testing_xml_during_iteration>
When iterating on a skill:

1. Make changes to XML structure
2. **Validate XML structure** (check tags, nesting, completeness)
3. Test with the agent on representative tasks
4. Observe if XML structure aids or hinders the agent's understanding
5. Iterate structure based on actual performance
</testing_xml_during_iteration>
</xml_structure_validation>

<observation_based_iteration>
<principle>
Iterate based on what you observe, not what you assume. Real usage reveals issues assumptions miss.
</principle>

<observation_categories>
<what_agent_reads>
Which sections does the agent actually read? Which are ignored? This reveals:
- Relevance of content
- Effectiveness of progressive disclosure
- Whether section names are clear
</what_agent_reads>

<where_agent_struggles>
Which tasks cause confusion or errors? This reveals:
- Missing context
- Unclear instructions
- Insufficient examples
- Ambiguous requirements
</where_agent_struggles>

<where_agent_succeeds>
Which tasks go smoothly? This reveals:
- Effective patterns
- Good examples
- Clear instructions
- Appropriate detail level
</where_agent_succeeds>

<unexpected_behaviors>
What does the agent do that surprises you? This reveals:
- Unstated assumptions
- Ambiguous phrasing
- Missing constraints
- Alternative interpretations
</unexpected_behaviors>
</observation_categories>

<iteration_pattern>
1. **Observe**: Run the agent on real tasks with current skill
2. **Document**: Note specific issues, not general feelings
3. **Hypothesize**: Why did this issue occur?
4. **Fix**: Make targeted changes to address specific issues
5. **Test**: Verify fix works on same scenario
6. **Validate**: Ensure fix doesn't break other scenarios
7. **Repeat**: Continue with next observed issue
</iteration_pattern>

<improvement_heuristics>
When evaluation output is available, inspect transcripts or detailed notes, not just final artifacts. Look for places where the skill caused useful behavior, wasted effort, or failed to change anything.

Improve by generalizing from evidence:
- Avoid changes that only satisfy one test prompt's wording
- Explain why a behavior matters instead of adding rigid all-caps rules
- Remove instructions that do not change behavior or only add token cost
- Move frequently repeated instructions into SKILL.md when every run needs them
- Move rare or detailed knowledge out to `knowledge/` when it is only needed for specific workflows
- Bundle repeated helper code in `scripts/` instead of letting each run recreate it
</improvement_heuristics>
</observation_based_iteration>

<progressive_refinement>
<principle>
Skills don't need to be perfect initially. Start minimal, observe usage, add what's missing.
</principle>

<initial_version>
Start with:
- Valid YAML frontmatter
- Required XML tags: objective, quick_start, success_criteria
- Minimal working example
- Basic success criteria

Skip initially:
- Extensive examples
- Edge case documentation
- Advanced features
- Detailed knowledge files
</initial_version>

<iteration_additions>
Add through iteration:
- Examples when patterns aren't clear from description
- Edge cases when observed in real usage
- Advanced features when users need them
- Knowledge files when SKILL.md approaches the 500-line target
- Validation scripts when errors are common
</iteration_additions>

<benefits>
- Faster to initial working version
- Additions solve real needs, not imagined ones
- Keeps skills focused and concise
- Progressive disclosure emerges naturally
- Documentation stays aligned with actual usage
</benefits>
</progressive_refinement>

<testing_discovery>
<principle>
Test that the agent can discover and use your skill when appropriate.
</principle>

<discovery_testing>
<test_description>
Test if the agent loads your skill when it should:

1. Start fresh conversation or execution context
2. Ask question that should trigger skill
3. Check if skill was loaded
4. Verify skill was used appropriately
</test_description>

<description_quality>
If skill isn't discovered:
- Check description includes trigger keywords
- Verify description is specific, not vague
- Ensure description explains when to use skill
- Test with different phrasings of the same request

The description is the primary discovery mechanism.
</description_quality>
</discovery_testing>

<trigger_eval_set>
For important skills, build a trigger eval set with both positives and near-miss negatives:
- 8-10 prompts that should trigger
- 8-10 prompts that should not trigger
- Realistic user phrasing, filenames, casual language, and partial context
- Adjacent-domain prompts that share keywords but need a different skill or no skill

Use `workflows/optimize-description.md` when trigger accuracy is the main problem.
</trigger_eval_set>
</testing_discovery>

<common_iteration_patterns>
<pattern name="too_verbose">
**Observation**: Skill works but uses lots of tokens

**Fix**:
- Remove obvious explanations
- Assume the agent knows common concepts
- Use examples instead of lengthy descriptions
- Move advanced content to knowledge files
</pattern>

<pattern name="too_minimal">
**Observation**: The agent makes incorrect assumptions or misses steps

**Fix**:
- Add explicit instructions where assumptions fail
- Provide complete working examples
- Define edge cases
- Add validation steps
</pattern>

<pattern name="poor_discovery">
**Observation**: Skill exists but the agent doesn't load it when needed

**Fix**:
- Improve description with specific triggers
- Add relevant keywords
- Test description against actual user queries
- Make description more specific about use cases
</pattern>

<pattern name="unclear_structure">
**Observation**: The agent reads wrong sections or misses relevant content

**Fix**:
- Use clearer XML tag names
- Reorganize content hierarchy
- Move frequently-needed content earlier
- Add explicit links to relevant sections
</pattern>

<pattern name="incomplete_examples">
**Observation**: The agent produces outputs that don't match expected pattern

**Fix**:
- Add more examples showing pattern
- Make examples more complete
- Show edge cases in examples
- Add anti-pattern examples (what not to do)
</pattern>
</common_iteration_patterns>

<iteration_velocity>
<principle>
Small, frequent iterations beat large, infrequent rewrites.
</principle>

<fast_iteration>
**Good approach**:
1. Make one targeted change
2. Test on specific scenario
3. Verify improvement
4. Commit change
5. Move to next issue

Total time: Minutes per iteration
Iterations per day: 10-20
Learning rate: High
</fast_iteration>

<slow_iteration>
**Problematic approach**:
1. Accumulate many issues
2. Make large refactor
3. Test everything at once
4. Debug multiple issues simultaneously
5. Hard to know what fixed what

Total time: Hours per iteration
Iterations per day: 1-2
Learning rate: Low
</slow_iteration>

<benefits_of_fast_iteration>
- Isolate cause and effect
- Build pattern recognition faster
- Less wasted work from wrong directions
- Easier to revert if needed
- Maintains momentum
</benefits_of_fast_iteration>
</iteration_velocity>

<success_metrics>
<principle>
Define how you'll measure if the skill is working. Quantify success.
</principle>

<objective_metrics>
- **Success rate**: Percentage of tasks completed correctly
- **Token usage**: Average tokens consumed per task
- **Iteration count**: How many tries to get correct output
- **Error rate**: Percentage of tasks with errors
- **Discovery rate**: How often skill loads when it should
</objective_metrics>

<subjective_metrics>
- **Output quality**: Does output meet requirements?
- **Appropriate detail**: Too verbose or too minimal?
- **Agent confidence**: Does the agent seem uncertain?
- **User satisfaction**: Does skill solve the actual problem?
</subjective_metrics>

<tracking_improvement>
Compare metrics before and after changes:
- Baseline: Measure without skill
- Initial: Measure with first version
- Iteration N: Measure after each change

Track which changes improve which metrics. Double down on effective patterns.
</tracking_improvement>
</success_metrics>
