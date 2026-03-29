#!/bin/bash
set -e

mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/vault-search
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/vault-write
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/web-research
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/tech-radar
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/project-mgmt
mkdir -p /data/.openclaw/.openclaw/workspace

# Clone vault directly into the workspace directory
VAULT_DIR=/data/.openclaw/.openclaw/workspace/vault
if [ -d "$VAULT_DIR/.git" ]; then
  cd "$VAULT_DIR" && git pull --rebase || true
else
  git clone "https://${GITHUB_PAT}@github.com/CCHerbst/Work-IPC.git" "$VAULT_DIR"
fi

CONFIG_DIR=/data/.openclaw/.openclaw/agents/cto-assistant
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

if [ ! -f /data/.openclaw/.openclaw/openclaw.json ]; then
  cat > /data/.openclaw/.openclaw/openclaw.json << OCJSON
{
  "gateway": {
    "mode": "local",
    "bind": "lan",
    "port": 18789
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "openrouter/deepseek/deepseek-v3.2",
        "fallbacks": ["openrouter/openai/gpt-5-mini"]
      }
    }
  },
  "channels": {
    "discord": {
      "token": "${DISCORD_BOT_TOKEN}",
      "groupPolicy": "open"
    }
  },
  "commands": {
    "allowFrom": {
      "discord": ["user:840799740315959307"]
    }
  }
}
OCJSON
  echo "OpenClaw config written."
else
  echo "Config exists, preserving."
fi

# Periodic vault sync
while true; do
  sleep 300
  cd "$VAULT_DIR" && git pull --rebase 2>/dev/null || true
done &

echo "Starting Atlas gateway..."
exec openclaw gateway
