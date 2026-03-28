---
name: vault-write
description: Create new files in the vault via GitHub API
triggers:
  - create a
  - add a
  - new meeting
  - new person
  - log meeting
---
# vault-write

Create files by committing to GitHub API at https://api.github.com/repos/CCHerbst/Work-IPC/contents/{path}. Follow frontmatter schemas in AGENTS.md. Ask for required fields if not provided. Apply vault conventions (no em dashes, no emojis, wiki-links, YAML frontmatter). Confirm with wiki-link after creation.
