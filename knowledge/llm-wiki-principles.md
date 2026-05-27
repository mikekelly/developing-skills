<overview>
LLM Wiki treats knowledge as a durable, maintained Markdown layer between raw sources and runtime answers. For skills, `knowledge/` is that layer: compiled guidance the agent can read selectively, update deliberately, and rely on across sessions.
</overview>

<skill_mapping>
- `SKILL.md` is the schema: it defines the invariant rules, navigation, indexes, and operating contract.
- `workflows/` are the operations: they say how to ingest, query, validate, and maintain skill knowledge for a specific task.
- `knowledge/` is the compiled wiki: focused pages of synthesized patterns, trade-offs, examples, and decision guidance.
- `templates/` and `scripts/` are supporting assets: reusable artifacts and executable tools, not knowledge dumps.
</skill_mapping>

<principles>
<principle name="source_first">
Raw sources remain the source of truth. Do not paste large source documents, transcripts, or scraped docs into `knowledge/`. Keep source material outside the skill or cite it, then compile the useful, durable guidance into concise knowledge files.
</principle>

<principle name="compiled_not_retrieved">
Knowledge files should contain already-synthesized understanding. The agent should not have to rediscover the same pattern from raw fragments each time it uses the skill.
</principle>

<principle name="persistent_and_maintained">
Treat knowledge as a living artifact. When new information supersedes old guidance, update the relevant page, note important constraints, and keep related pages consistent.
</principle>

<principle name="entry_points_and_traversal">
`knowledge_index` should list top-level entry points, major topic areas, and canonical starting pages. It is not an exhaustive manifest. Additional pages can be discovered by traversing links from entry-point pages, workflow `required_reading`, or related knowledge pages.
</principle>

<principle name="linked_corpus">
Knowledge files should form a traversable corpus. Cross-link related files when a decision depends on another topic, and avoid dead-end clusters that no workflow or entry-point page can plausibly lead to.
</principle>

<principle name="query_then_compound">
Useful answers, comparisons, and decisions should not disappear into chat history. When they generalize beyond the current task, fold them back into the relevant knowledge file.
</principle>
</principles>

<progressive_disclosure_alignment>
LLM Wiki and progressive disclosure reinforce each other. The wiki makes knowledge durable; progressive disclosure keeps loading selective. SKILL.md gives the map, workflows choose the relevant pages, and `knowledge/` holds the maintained substance.
</progressive_disclosure_alignment>

<maintenance_loop>
Use this loop when adding or revising skill knowledge:

1. **Ingest**: Read the source or user-provided context. Extract the reusable principle, trade-off, example, or workflow implication.
2. **Compile**: Write concise guidance in the smallest relevant knowledge file. Prefer decision rules and examples over summaries.
3. **Connect**: Add the file to `knowledge_index` if it is a top-level entry point; otherwise link to it from a related page or add it to any workflow `required_reading` that should load it directly.
4. **Cross-check**: Look for related files that now need edits, links, or contradiction removal.
5. **Lint**: Periodically scan for stale claims, duplicated guidance, unreachable clusters, missing useful links, and files that grew too broad.
</maintenance_loop>

<anti_patterns>
- Raw dumps in `knowledge/` with no synthesis.
- Treating `knowledge_index` as an exhaustive manifest that lists every page.
- Knowledge pages that are not discoverable through entry points, workflow required reading, or links from related pages.
- Workflows that tell the agent to read all of `knowledge/` by default.
- Nested knowledge chains that require opening file after file to understand a topic.
- Stale library versions, dated recommendations, or contradicted guidance without an update note.
- Chat-specific answers stored as knowledge when they are not reusable.
</anti_patterns>
