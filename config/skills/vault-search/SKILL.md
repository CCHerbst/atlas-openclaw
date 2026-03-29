---
name: vault-search
description: Search and read the Obsidian vault to answer questions about IP Corporation
triggers:
  - who is
  - what is
  - tell me about
  - find
  - search
  - look up
  - what systems
  - what vendors
  - how many
  - where is
  - what's deployed
  - show me
---
# Vault Search

Search and read the Obsidian vault at vault/ to answer questions about IP Corporation's people, systems, vendors, strategy, meetings, technology landscape, and Tech Radar signals.

## Search Priority by Query Type

Always check the vault before suggesting web research. Route to the most specific source first.

| Query Type | Primary Source | Secondary Source | Example |
|---|---|---|---|
| Person | `vault/People/Contacts/` (search by full_name, title, company) | `vault/Context/Key Personnel.md` (strategic context) | "Who is Jim Cecere?" |
| System | `vault/Technologies/Systems/` (search by system_name, vendor) | `vault/Context/Technology Systems Inventory.md` (overview) | "What MES do we use?" |
| Vendor | `vault/Context/Vendors/` (search by vendor_name) | `vault/Technologies/Systems/` (their products we use) | "Tell me about Rockwell" |
| Strategy/Roadmap | `vault/Strategy/Technology Strategy.md` | `vault/Strategy/Technology Resource Plan.md`, `vault/Strategy/Strategic Principles.md` | "What's planned for Year 2?" |
| Facility/Site | `vault/Context/Facilities and Sites.md` | `vault/Context/Technology Systems Inventory.md` | "What's deployed at HK Research?" |
| Meeting | `vault/Meetings/` (search by meeting_date, title, attendees in content) | `vault/People/Contacts/` (attendee details) | "What did we discuss with Dave?" |
| Tech Radar | `vault/Tech Radar/Signals/` (filter by domain, tier, score, action, date) | `vault/Tech Radar/Weekly Briefings/` | "Any new signals this week?" |
| Org structure | `vault/Context/Key Personnel.md` | `vault/People/Contacts/` | "Who reports to Joe Huff?" |
| Competitive | `vault/Strategy/Technology Analysis.md` (CONFIDENTIAL: summarize only) | `vault/Tech Radar/Research/` (catch-up notes) | "What is Hexion doing with AI?" |
| General | Grep across vault (exclude .obsidian/ and Sandbox/) | Suggest web research if not found | "Where do we mention MDM?" |

## How to Search

1. **By frontmatter:** Read the file and check YAML properties (full_name, system_name, vendor_name, meeting_date, domain, tier, score, action, status)
2. **By filename:** Files are named descriptively (e.g., `Jim Cecere.md`, `Infor M3.md`, `Microsoft.md`)
3. **By content:** Search file contents for keywords when frontmatter doesn't match
4. **By folder listing:** List directory contents when the query is broad ("What vendors do we have?")

## Output Format

- Lead with the answer, not the search process
- Cite the source file using [[wiki-links]] or file paths
- If multiple files are relevant, synthesize across them rather than listing each one separately
- For person queries: include title, company, and any strategic context from Key Personnel
- For system queries: include vendor, deployment status, and which subsidiaries use it
- For vendor queries: include relationship type, products we use, and strategic importance
- If information conflicts between documents, note the discrepancy

## What Not to Search
- `vault/Sandbox/` unless Chris explicitly directs you to a specific file
- `vault/.obsidian/` never
- Do not fabricate content. If the vault doesn't have the answer, say so and offer to do web research.
