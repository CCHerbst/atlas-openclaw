FROM node:22-alpine

RUN apk add --no-cache tini curl bash git \
    && npm install -g openclaw@latest pm2

RUN mkdir -p /data/.openclaw/agents/cto-assistant/skills \
    && mkdir -p /data/vault \
    && mkdir -p /app/config

COPY config/ /app/config/
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV OPENCLAW_HOME=/data/.openclaw
ENV NODE_ENV=production

WORKDIR /data

EXPOSE 18789

ENTRYPOINT ["tini", "--"]
CMD ["/app/start.sh"]
