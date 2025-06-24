#FROM node:20.19.2-alpine3.21
FROM demonstrationorg/dhi-node:20.19.2-alpine3.21-dev

# Metadata Labels
LABEL org.opencontainers.image.vendor="DemonstrationOrg" \
      org.opencontainers.image.title="dhi-demo-service" \
      org.opencontainers.image.description="Demo service for DHI" \
      org.opencontainers.image.version="0.1.0"

# FinOps Labels
LABEL finops.account="demo-account" \
      finops.costcenter="cc-123" \
      finops.project="dhi-demo" \
      finops.environment="development" \
      finops.team="platform-engineering"

# Kubernetes Hierarchy Labels
LABEL app.kubernetes.io/name="dhi-demo-service" \
      app.kubernetes.io/instance="demo-instance" \
      app.kubernetes.io/version="0.1.0" \
      app.kubernetes.io/component="web-service" \
      app.kubernetes.io/part-of="dhi-platform" \
      app.kubernetes.io/managed-by="docker" \
      app.kubernetes.io/environment="development"

ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

COPY package.json ./

RUN  apk add --no-cache npm \
&& npm i --no-optional \
&& npm cache clean --force \
&& apk del npm

COPY . /app

CMD ["node","/app/app.js"]

EXPOSE 3000