#!/usr/bin/env ruby
# Validates the developing-skills repo without external dependencies.

require "json"
require "yaml"

ROOT = File.expand_path("..", __dir__)
errors = []

def read(path)
  File.read(File.join(ROOT, path))
end

frontmatter = read("SKILL.md")[/\A---\n(.*?)\n---/m, 1]
if frontmatter.nil?
  errors << "SKILL.md is missing YAML frontmatter"
else
  metadata = YAML.safe_load(frontmatter)
  errors << "SKILL.md name must match directory basename" unless metadata["name"] == File.basename(ROOT)
  errors << "SKILL.md description is missing" if metadata["description"].to_s.strip.empty?
  errors << "SKILL.md description exceeds 1024 characters" if metadata["description"].to_s.length > 1024
end

Dir[File.join(ROOT, "{templates,evals}", "*.json")].each do |path|
  JSON.parse(File.read(path))
rescue JSON::ParserError => e
  errors << "#{path.delete_prefix(ROOT + "/")} is invalid JSON: #{e.message}"
end

Dir[File.join(ROOT, "workflows", "*.md")].each do |path|
  rel = path.delete_prefix(ROOT + "/")
  text = File.read(path)
  %w[required_reading process success_criteria].each do |tag|
    errors << "#{rel} is missing <#{tag}>" unless text.include?("<#{tag}>")
  end
end

stale_patterns = [
  [/\(user\)/, "frontmatter/runtime marker '(user)'"],
  [/2024 2025/, "hard-coded old year pair"],
  [/before 2023/, "hard-coded stale date cutoff"],
  [/Remove ALL markdown/i, "obsolete absolute Markdown-heading rule"],
  [/pure XML/i, "obsolete pure-XML terminology"]
]

Dir[File.join(ROOT, "{SKILL.md,workflows/*.md,knowledge/*.md,templates/*.md,README.md,evals/*.json}")].each do |path|
  rel = path.delete_prefix(ROOT + "/")
  text = File.read(path)
  stale_patterns.each do |pattern, label|
    errors << "#{rel} contains #{label}" if text.match?(pattern)
  end
end

files = Dir[File.join(ROOT, "{SKILL.md,workflows/*.md,knowledge/*.md,templates/*.md,README.md}")]
ignore_ref = /(\{|\}|relevant-file|another-file|option-a|option-b|option-c|workflow-name|plan-template|api-operations|troubleshooting|guide|finance|sales|helper|main|workflow-a|workflow-b|path\/to|add-feature|write-tests|optimize-performance|build-new|debug-|ship-)/

files.each do |path|
  rel = path.delete_prefix(ROOT + "/")
  in_fence = false
  File.readlines(path).each_with_index do |line, index|
    in_fence = !in_fence if line.start_with?("```")
    next if in_fence

    line.scan(/\b(?:knowledge|workflows|templates|evals)\/[A-Za-z0-9._{}-]+/) do |ref|
      next if ref.match?(ignore_ref)
      next if File.exist?(File.join(ROOT, ref))

      errors << "#{rel}:#{index + 1} references missing #{ref}"
    end
  end
end

if errors.empty?
  puts "developing-skills validation passed"
else
  warn errors.join("\n")
  exit 1
end
