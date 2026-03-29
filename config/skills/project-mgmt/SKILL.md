---
name: project-mgmt
description: Track tasks, manage meetings, and maintain roadmap awareness
triggers:
  - action items
  - open tasks
  - meeting prep
  - prepare for meeting
  - meeting summary
  - roadmap
  - what's due
  - prepare for
  - upcoming
  - what should I focus on
  - post-meeting
  - decisions
---
# Project Management

Track tasks, prepare for meetings, structure meeting notes, and maintain awareness of the technology roadmap.

## Task Tracking

### Sources of Tasks
Tasks exist in multiple vault locations. When Chris asks about open tasks or what to focus on, check all of these:

| Source | Location | What to Look For |
|---|---|---|
| Meeting action items | `vault/Meetings/*.md` | Unchecked items (`- [ ]`) in Action Items sections |
| Learning Board | `vault/Tech Radar/Learning Board.md` | Tasks in Inbox, This Week, and In Progress lanes |
| Tech Radar signals | `vault/Tech Radar/Signals/` | Signals with `action: "act"` and `status: "queued"` |
| Strategy roadmap | `vault/Strategy/Technology Strategy.md` | Year 1 initiatives and their timelines |

### "What should I focus on this week?"
When Chris asks this, synthesize across all sources:
1. List items in the Learning Board "This Week" lane
2. List any unchecked action items from recent meetings (last 2 weeks)
3. Flag any Tech Radar signals requiring action
4. Note any upcoming strategy milestones from the Technology Strategy
5. Prioritize: action-required signals first, then meeting action items, then learning tasks

## Meeting Preparation

When Chris says **"Prepare for meeting with [person/topic]"** or **"Meeting prep for [person]"**:

1. **Attendee context**: Search `vault/People/Contacts/` for each attendee. Pull their title, company, department, and any notes.
2. **Meeting history**: Search `vault/Meetings/` for previous meetings with the same attendees. Summarize key decisions and open action items.
3. **Relevant signals**: Check `vault/Tech Radar/Signals/` for recent signals related to the meeting topic or the attendee's domain.
4. **Strategy context**: If the meeting topic relates to a technology initiative, pull relevant sections from the Technology Strategy.
5. **Vendor context**: If meeting with a vendor, pull their profile from `vault/Context/Vendors/`.

Deliver as a structured prep brief:
- **Attendee(s)**: name, title, last interaction
- **Previous meetings**: dates, key decisions, open items
- **Relevant context**: signals, strategy items, vendor notes
- **Suggested topics**: based on open items and recent developments

## Post-Meeting Structuring

When Chris shares **raw meeting notes** or says **"Structure these notes"** or **"Log this meeting"**:

1. Parse the raw notes for:
   - Key discussion points
   - Decisions made
   - Action items (who, what, when)
   - Attendees mentioned
2. Structure into the Meeting Note template (see AGENTS.md schema):
   - Meeting details table
   - Attendees list
   - Meeting Summary (Key Discussion Points, Decisions Made)
   - Action Items table (Action, Owner, Due Date, Status)
3. Ask Chris for any missing required fields (date, time, location if not obvious)
4. Create the file via vault-write skill
5. List the extracted action items for Chris to confirm

## Roadmap Awareness

### Technology Strategy Queries
Read `vault/Strategy/Technology Strategy.md` to answer:
- "What's planned for Year [1-5]?"
- "When is the [MES evaluation / ERP migration / etc.]?"
- "What are the Year 1 priorities?"
- "What depends on what?" (initiative sequencing and dependencies)

### Resource Plan Queries
Read `vault/Strategy/Technology Resource Plan.md` to answer:
- "What's the budget for [initiative]?"
- "How many people do we need for [initiative]?"
- "What vendor partnerships are planned?"

### Strategic Principles
Read `vault/Strategy/Strategic Principles.md` to answer:
- "Which principle does this align with?"
- "How should we prioritize between X and Y?"

### Cross-Reference with Current State
When answering roadmap questions, cross-reference with:
- `vault/Context/Technology Systems Inventory.md` for current deployment status
- `vault/Context/Facilities and Sites.md` for site-specific readiness
- `vault/Tech Radar/Signals/` for recent developments that may affect the plan

## Decision Tracking

When Chris mentions a decision in conversation:
- Note it and offer to append it to the relevant meeting note or create a new note
- If the decision affects the Technology Strategy, flag it ("This changes the Year 2 MES timeline")
- Never modify Strategy documents directly; flag for Chris's review
