---
name: tech-radar
description: Query and manage the Tech Radar technology signal scanning system
triggers:
  - signals
  - tech radar
  - new signals
  - learning board
  - weekly briefing
  - what's trending
  - action items
  - signal summary
  - radar
  - what's new in tech
---
# Tech Radar

Query and manage the automated Tech Radar system at vault/Tech Radar/. This system scans 44 RSS feeds + 2 HTML-scraped vendor blogs daily, classifies articles against IP Corporation's context, scores them, and commits signal cards to the vault.

## Read Operations

### Signal Queries
Read files in `vault/Tech Radar/Signals/` and filter by frontmatter properties:

| Property | Values | Example Query |
|---|---|---|
| date | YYYY-MM-DD | "Signals from the last 3 days" |
| domain | Data Platform and Architecture, AI/ML Strategy and Application, Manufacturing Intelligence, Microsoft Ecosystem, Rockwell / FactoryTalk Ecosystem, Infor Ecosystem, Hexagon Ecosystem, Salesforce Ecosystem, OT/IIoT Convergence, MES Landscape, Materials Informatics and Formulation AI, Industry and Competitive Intelligence, Emerging and Horizon Technologies, Regulation and Standards | "Show me OT/IIoT signals" |
| tier | deep, working, awareness | "What deep-tier signals came in?" |
| score | 0.0 to 10.0 | "Signals scoring above 8" |
| action | ignore, watch, learn, act | "Anything requiring action?" |
| status | queued, active, completed, archived | "What signals have I not reviewed?" |

### Common Queries
- **"Any new signals?"**: List signals from the last 48 hours, sorted by score descending
- **"Signals requiring action"**: Filter for `action: "act"` and `status != "completed"`
- **"Signal summary"**: Count signals by domain, tier, and action
- **"What's trending?"**: Identify domains with elevated signal volume over the past week
- **"Latest briefing"**: Read the most recent file in `vault/Tech Radar/Weekly Briefings/`

### Learning Board
Read `vault/Tech Radar/Learning Board.md` and report tasks by Kanban lane:
- **This Week**: what Chris is actively focusing on
- **In Progress**: deeper dives, multi-week items
- **Inbox**: queued items not yet started
- **Watch**: monitoring but not acting
- **Completed**: done

### Research Notes
Read files in `vault/Tech Radar/Research/` for catch-up research on vendor ecosystems and technology landscapes.

### System Reference
Read `vault/Tech Radar/CLAUDE.md` for the full system architecture, including how to add/remove feeds, change the LLM model, adjust scoring thresholds, or modify the classification prompt.

## Write Operations (Limited)

### Learning Board Only
Edit `vault/Tech Radar/Learning Board.md` via GitHub API to:
- **Add task**: Insert `- [ ] Task description` under the appropriate lane heading
- **Move task**: Remove from one lane section, add to another
- **Complete task**: Change `- [ ]` to `- [x]` and move to the Completed section

### Signal Status
Edit individual signal card frontmatter via GitHub API to change `status` (e.g., from `queued` to `active` or `completed`).

### Do Not Modify
- Signal card content (title, summary, so_what, score) is auto-generated; do not edit
- Weekly briefings are auto-generated; do not edit
- Research notes are reference material; do not edit
- RSS Sources, Signal Schema, and CLAUDE.md are system configuration; do not edit

## Cross-Referencing
When reporting signals, connect them to the broader context:
- Does a signal relate to a system in Technologies/Systems/?
- Does it affect a planned initiative in the Technology Strategy?
- Does it involve a vendor in Context/Vendors/?
- Has this topic appeared in multiple signals recently (pattern)?
