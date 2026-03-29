# System Instructions

## Vault Location
vault/

## Vault Structure
| Folder | Purpose | Access |
|---|---|---|
| Context/ | Foundational company data (IP Corporation overview, systems inventory, facilities, key personnel, vendors) | Read |
| Context/Vendors/ | Individual vendor profiles (10 vendors) | Read |
| Strategy/ | Technology roadmap, resource plan, strategic principles, competitive analysis, CTO role | Read |
| Technologies/Systems/ | Individual system profiles (21 deployed systems) | Read |
| Technologies/Topics/ | Technology concepts, patterns, fields | Read |
| Tech Radar/ | Automated signal scanning system | Read |
| Tech Radar/Signals/ | Auto-generated signal cards (daily) | Read |
| Tech Radar/Weekly Briefings/ | Monday summaries | Read |
| Tech Radar/Learning Board.md | Kanban board (Inbox, This Week, In Progress, Watch, Completed) | Read |
| People/Contacts/ | Individual personnel files (53 contacts) | Read |
| Meetings/ | Meeting notes with structured frontmatter | Read |
| Projects/ | Active project workspaces | Read |
| Sandbox/ | Non-authoritative scratch space | DO NOT ACCESS unless explicitly asked |
| .obsidian/ | Vault configuration | DO NOT MODIFY |

## Git Sync
The vault at vault/ is a git clone of CCHerbst/Work-IPC that auto-pulls every 5 minutes. For write operations, use the GitHub API to commit files directly to the repo.

## GitHub API for Writing
To create or update vault files, use the GitHub API:
- Endpoint: https://api.github.com/repos/CCHerbst/Work-IPC/contents/{path}
- Method: PUT
- Headers: Authorization: token {GITHUB_PAT environment variable}
- Body: { "message": "description", "content": "base64 encoded content", "branch": "main" }

## File Creation Schemas

### Meeting Note (Meetings/{Title}_{YYYY-MM-DD}.md)
Required frontmatter: title, date, meeting_date (YYYY-MM-DD), meeting_time (HH:MM), meeting_duration (minutes), meeting_type ("Misc"), location, summary, banner (Obsidian/pixel-banner-images/meeting_banner.png)

### Person (People/Contacts/{Full Name}.md)
Required frontmatter: full_name, firstname, lastname, title, company, location, department, manager, email, website, employee_type ("Perm"), employee_image_url

### Vendor (Context/Vendors/{Name}.md)
Required frontmatter: vendor_name, vendor_status ("active"), relationship_type, website, headquarters, partnership_tier, contract_status, contract_renewal, annual_spend, ip_corp_owner, strategic_importance

### System (Technologies/Systems/{Name}.md)
Required frontmatter: system_name, system_category, vendor, system_status, deployment, scope

### Topic (Technologies/Topics/{Name}.md)
Required frontmatter: title, date, tags, topic_status, summary
