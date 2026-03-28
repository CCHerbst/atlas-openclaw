#!/bin/bash
set -e

# Create directories (volume mount overwrites Dockerfile mkdir)
mkdir -p /data/.openclaw/agents/cto-assistant/skills/vault-search
mkdir -p /data/.openclaw/agents/cto-assistant/skills/vault-write
mkdir -p /data/.openclaw/agents/cto-assistant/skills/web-research
mkdir -p /data/.openclaw/agents/cto-assistant/skills/tech-radar
mkdir -p /data/.openclaw/agents/cto-assistant/skills/project-mgmt
mkdir -p /data/vault

# Clone/update the vault for read access
if [ -d /data/vault/.git ]; then
  cd /data/vault && git pull --rebase || true
else
  git clone "https://${GITHUB_PAT}@github.com/CCHerbst/Work-IPC.git" /data/vault
fi

# Copy agent config files from repo into openclaw home if not already present
CONFIG_DIR=/data/.openclaw/agents/cto-assistant
if [ ! -f "$CONFIG_DIR/SOUL.md" ]; then
  echo "First run: copying agent configuration..."
  cp /app/config/SOUL.md "$CONFIG_DIR/"
  cp /app/config/USER.md "$CONFIG_DIR/"
  cp /app/config/AGENTS.md "$CONFIG_DIR/"
  cp /app/config/openclaw.json /data/.openclaw/
  echo "# Memory" > "$CONFIG_DIR/MEMORY.md"

  for skill in vault-search vault-write web-research tech-radar project-mgmt; do
    cp "/app/config/skills/$skill/SKILL.md" "$CONFIG_DIR/skills/$skill/"
  done
  echo "Configuration copied."
fi

# Set up periodic vault sync (every 5 minutes)
while true; do
  cd /data/vault && git pull --rebase 2>/dev/null || true
  sleep 300
done &

# Start openclaw gateway in foreground (container mode)
echo "Starting Atlas gateway..."
exec openclaw gateway
