---
name: vault-write
description: Create new files and update existing files in the Obsidian vault
triggers:
  - create a
  - add a
  - new meeting
  - new person
  - new vendor
  - new system
  - new topic
  - log meeting
  - add contact
  - update
  - append
  - add notes to
---
# Vault Write

Create new files and update existing files in the vault by committing to the GitHub API. Follow all vault conventions and frontmatter schemas defined in AGENTS.md.

## Supported File Types

| Type | Path Pattern | Required Fields Before Creating |
|---|---|---|
| Meeting Note | `Meetings/{Title}_{YYYY-MM-DD}.md` | title, meeting_date, meeting_time, location |
| Person | `People/Contacts/{Full Name}.md` | full_name (firstname + lastname), title, company |
| Vendor | `Context/Vendors/{Name}.md` | vendor_name, relationship_type |
| System | `Technologies/Systems/{Name}.md` | system_name, system_category, vendor |
| Topic / Research | `Technologies/Topics/{Name}.md` | title |

## How to Write

### Creating New Files
1. Determine the file type from Chris's request
2. Ask for any required fields not provided (don't guess)
3. Build the file content following the exact frontmatter schema and body structure from AGENTS.md
4. Commit via GitHub API:
   - **PUT** `https://api.github.com/repos/CCHerbst/Work-IPC/contents/{path}`
   - **Headers:** `Authorization: token {GITHUB_PAT}`
   - **Body:** `{"message": "Atlas: created {filename}", "content": "{base64}", "branch": "main"}`
5. Confirm to Chris: "Created [[filename]]"

### Updating Existing Files
1. **GET** the file first to obtain the current content and `sha`
2. Modify the content (append notes, update a section, add action items)
3. **PUT** with the original `sha` included:
   - **Body:** `{"message": "Atlas: updated {filename}", "content": "{base64}", "sha": "{sha}", "branch": "main"}`
4. Confirm to Chris what was changed

## Rules

- **Ask before creating** if the request is ambiguous ("Did you want a Person file or a Meeting note?")
- **Never overwrite** without confirming, unless appending notes or action items to an existing file
- **Never move files** between folders
- **Never delete files**
- **Apply all vault conventions:**
  - No em dashes
  - No emojis
  - [[wiki-links]] for cross-references
  - YAML frontmatter with proper schemas
  - No blank lines before or after headings
  - Bold for key terms, tables for structured data, horizontal rules between sections
- **Include Dataview queries** in Person files (Meetings query, Note References query) as specified in AGENTS.md
- **Include the banner property** in Meeting files: `banner: Obsidian/pixel-banner-images/meeting_banner.png`
- **Include [[Chris Herbst]]** in the attendees list for meeting notes

## Commit Message Convention
- New files: `"Atlas: created {filename}"`
- Updates: `"Atlas: updated {filename}"`
- Appended notes: `"Atlas: appended notes to {filename}"`
