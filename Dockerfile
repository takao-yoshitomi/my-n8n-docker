FROM node:24-alpine

RUN apk add --no-cache \
    imagemagick \
    poppler-utils \
    poppler-data \
    font-noto-cjk \
    python3 \
    py3-setuptools \
    make \
    g++ \
    bash \
    graphicsmagick

RUN npm install -g n8n@2.14.2 --omit=dev --legacy-peer-deps

ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*

ENV N8N_PORT=10000
ENV PORT=10000
ENV N8N_USER_FOLDER=/data

RUN mkdir -p /data && chown -R node:node /data

EXPOSE 10000

USER node
CMD ["n8n"]
