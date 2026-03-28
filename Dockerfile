FROM node:22-alpine

RUN apk add --no-cache bash git && npm install -g openclaw@latest

COPY config/ /app/config/
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV OPENCLAW_HOME=/data/.openclaw
EXPOSE 18789

CMD ["/app/start.sh"]
