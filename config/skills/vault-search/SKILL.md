---
name: vault-search
description: Search and read the Obsidian vault
triggers:
  - who is
  - what is
  - find
  - search
  - look up
---
# vault-search

Search the vault at /data/vault/ to answer questions. Priority: check specific folder first (People/Contacts for people, Technologies/Systems for systems, Context/Vendors for vendors, Strategy for strategy, Meetings for meetings, Tech Radar/Signals for signals). If not found, grep the vault excluding .obsidian/ and Sandbox/. If not in vault, suggest web research. Cite sources as wiki-links.
