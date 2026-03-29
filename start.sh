#!/bin/bash
set -e

mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/vault-search
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/vault-write
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/web-research
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/tech-radar
mkdir -p /data/.openclaw/.openclaw/agents/cto-assistant/skills/project-mgmt
mkdir -p /data/.openclaw/.openclaw/workspace

VAULT_DIR=/data/.openclaw/.openclaw/workspace/vault
if [ -d "$VAULT_DIR/.git" ]; then
  cd "$VAULT_DIR" && git pull --rebase || true
else
  git clone "https://${GITHUB_PAT}@github.com/CCHerbst/Work-IPC.git" "$VAULT_DIR"
fi

# Always refresh agent config (SOUL, USER, AGENTS, skills) from the Docker image
CONFIG_DIR=/data/.openclaw/.openclaw/agents/cto-assistant
cp /app/config/SOUL.md "$CONFIG_DIR/"
cp /app/config/USER.md "$CONFIG_DIR/"
cp /app/config/AGENTS.md "$CONFIG_DIR/"
cp /app/config/HEARTBEAT.md "$CONFIG_DIR/" 2>/dev/null || true
# Only copy BOOTSTRAP.md if it hasn't been run yet (it self-deletes after first run)
[ ! -f "$CONFIG_DIR/.bootstrap-done" ] && cp /app/config/BOOTSTRAP.md "$CONFIG_DIR/" 2>/dev/null || true
for skill in vault-search vault-write web-research tech-radar project-mgmt; do
  cp "/app/config/skills/$skill/SKILL.md" "$CONFIG_DIR/skills/$skill/"
done
[ -f "$CONFIG_DIR/MEMORY.md" ] || echo "# Memory" > "$CONFIG_DIR/MEMORY.md"
echo "Agent config refreshed."

# Only write openclaw.json on first run (preserve OpenClaw's managed config)
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
  echo "OpenClaw config preserved."
fi

# Clear stale gateway state
rm -rf /data/.openclaw/.openclaw/gateway/state 2>/dev/null || true

# Run doctor
openclaw doctor --fix 2>/dev/null || true

# Periodic vault sync
while true; do
  sleep 300
  cd "$VAULT_DIR" && git pull --rebase 2>/dev/null || true
done &

echo "Starting Atlas gateway..."
exec openclaw gateway
