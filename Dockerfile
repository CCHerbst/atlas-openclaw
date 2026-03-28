FROM node:22-alpine

RUN apk add --no-cache tini curl bash git \
    openjdk17-jre-headless \
    && npm install -g openclaw@latest pm2

# signal-cli installation
ARG SIGNAL_CLI_VERSION=0.13.12
RUN curl -sL "https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_CLI_VERSION}/signal-cli-${SIGNAL_CLI_VERSION}-Linux.tar.gz" \
    | tar xz -C /opt/ \
    && ln -s /opt/signal-cli-${SIGNAL_CLI_VERSION}/bin/signal-cli /usr/local/bin/signal-cli

# Create data directory
RUN mkdir -p /data/.openclaw/agents/cto-assistant/skills \
    && mkdir -p /data/vault

ENV OPENCLAW_HOME=/data/.openclaw
ENV NODE_ENV=production

WORKDIR /data

EXPOSE 18789

ENTRYPOINT ["tini", "--"]
CMD ["pm2-runtime", "openclaw", "--", "gateway", "start"]
