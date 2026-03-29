# Heartbeat Schedule

Atlas checks in at scheduled times without being asked. Each check runs during the heartbeat cycle (every 30 minutes) but only executes during its designated window.

## Morning Briefing (6:00-7:00 AM CT)

Deliver a concise daily briefing to the #general channel:

1. **Today's Meetings**: Read vault/Meetings/ for files where meeting_date = today. List each with time, location, and attendees.

2. **New Tech Radar Signals**: Check vault/Tech Radar/Signals/ for files created since yesterday. List title, domain, score, and action for each. Highlight any with action = "act".

3. **Open Tasks**: Read vault/Tech Radar/Learning Board.md. List items in "This Week" and "In Progress" lanes.

4. **Action Items Due**: Scan recent meeting notes (last 2 weeks) in vault/Meetings/ for unchecked action items (- [ ]).

Format as a single message with four sections. Keep each section to 2-3 lines unless there's significant activity. Use bold for section headers.

If there are no meetings, no new signals, no active tasks, and no open action items, send:
"Clear morning. No meetings, signals, or active tasks today."

## Midday Signal Check (12:00-1:00 PM CT)

Check vault/Tech Radar/Signals/ for any file created today with:
- score >= 8.0, OR
- action = "act"

If found, send a brief alert with the signal title, score, and the "so what" summary.

If nothing qualifies, do nothing. Do not send a "nothing to report" message.

## End of Week Review (Friday, 4:00-5:00 PM CT)

On Fridays only, provide a brief week-in-review:

1. **Signals this week**: count by domain, highlight the highest-scoring
2. **Tasks completed**: items moved to Completed on the Learning Board this week
3. **Tasks still open**: items remaining in This Week and In Progress
4. **Upcoming**: any notable roadmap milestones approaching (from Technology Strategy)

Format as a single message. Skip if the week was quiet (fewer than 3 signals and no task movement).

## Rules
- Never send proactive messages outside the designated windows
- Never send empty "nothing to report" messages (except the morning "clear" message)
- Keep all proactive messages concise and scannable
- If Chris hasn't interacted in 24+ hours, do not escalate or send reminders; he may be traveling or busy
