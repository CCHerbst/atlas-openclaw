---
name: web-research
description: Perform structured research using Perplexity and Manus, save results to vault
triggers:
  - research
  - look up online
  - what's new with
  - latest news
  - current status of
  - compare
  - market
  - deep dive
  - quick research
---
# Web Research

Perform structured research using external tools. Save results to the vault at Technologies/Topics/.

## Research Sizing
When Chris requests research, determine the size:
- **"Research X, small"** or **"Quick research on X"**: Small
- **"Research X, medium"** or **"Research X"** (no size): Medium (default)
- **"Research X, large"** or **"Deep dive on X"**: Large

## Tools by Size

### Perplexity API (Small and Medium)
- Endpoint: https://api.perplexity.ai/chat/completions
- API key: from PERPLEXITY_API_KEY environment variable
- **Small:** use `sonar` model for quick web-grounded answers
- **Medium:** use `sonar-deep-research` model for comprehensive investigation
- Use ONLY for research tasks, not general conversation

### Manus.ai (Large Only)
- Use for large research tasks requiring autonomous multi-step investigation
- Describe the objective clearly with IP Corporation context
- Use ONLY for large research tasks, not small/medium or general conversation

### Vault (All Sizes)
- Always check the vault FIRST before external research
- Cross-reference findings with: Technology Systems Inventory, Strategy documents, Vendor profiles, Tech Radar signals
- Note discrepancies between external research and vault content

## Query Framing
Always frame research queries with IP Corporation context when relevant:
- "For a specialty chemicals/composites manufacturer with $750M revenue..."
- "In the context of process manufacturing with Rockwell/Allen-Bradley automation..."
- "For an organization using Microsoft Fabric as its data platform..."

## Output

### In Discord
Deliver a summary of key findings, sized appropriately:
- Small: 3-5 bullet points with the key takeaway
- Medium: structured summary with sections
- Large: executive summary with pointer to the full document

### In Vault
Save the full research to `Technologies/Topics/{Topic Name}.md` via GitHub API using the research schema from AGENTS.md. Include:
- Proper frontmatter with `research_size` field
- All body sections for the appropriate size
- Numbered references with URLs
- "Relevance to IP Corporation" section connecting findings to our environment

### Post-Research
- If findings affect the Technology Strategy or a vendor relationship, flag it explicitly
- If a relevant Tech Radar signal exists, cross-reference it
- Suggest follow-up research if the topic warrants deeper investigation
