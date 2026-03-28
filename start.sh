#!/bin/bash
set -e

mkdir -p /data/.openclaw/agents/cto-assistant/skills/vault-search
mkdir -p /data/.openclaw/agents/cto-assistant/skills/vault-write
mkdir -p /data/.openclaw/agents/cto-assistant/skills/web-research
mkdir -p /data/.openclaw/agents/cto-assistant/skills/tech-radar
mkdir -p /data/.openclaw/agents/cto-assistant/skills/project-mgmt
mkdir -p /data/vault

# Clone/update vault
if [ -d /data/vault/.git ]; then
  cd /data/vault && git pull --rebase || true
else
  git clone "https://${GITHUB_PAT}@github.com/CCHerbst/Work-IPC.git" /data/vault
fi

# Copy config on first run
CONFIG_DIR=/data/.openclaw/agents/cto-assistant
if [ ! -f "$CONFIG_DIR/SOUL.md" ]; then
  echo "First run: copying agent configuration..."
  cp /app/config/SOUL.md "$CONFIG_DIR/"
  cp /app/config/USER.md "$CONFIG_DIR/"
  cp /app/config/AGENTS.md "$CONFIG_DIR/"
  echo "# Memory" > "$CONFIG_DIR/MEMORY.md"
  for skill in vault-search vault-write web-research tech-radar project-mgmt; do
    cp "/app/config/skills/$skill/SKILL.md" "$CONFIG_DIR/skills/$skill/"
  done
  echo "Configuration copied."
fi

# Ensure openclaw config exists with gateway.mode=local
if [ ! -f /data/.openclaw/openclaw.json ]; then
  cat > /data/.openclaw/openclaw.json << 'OCJSON'
{
  "gateway": {
    "mode": "local",
    "bind": "0.0.0.0",
    "port": 18789
  }
}
OCJSON
  echo "OpenClaw config created."
fi

# Periodic vault sync
while true; do
  cd /data/vault && git pull --rebase 2>/dev/null || true
  sleep 300
done &

echo "Starting Atlas gateway..."
exec openclaw gateway --allow-unconfigured
