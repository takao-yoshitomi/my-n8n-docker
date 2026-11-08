# 公式の n8n 2.14.2 イメージは Node 24.13.1 で出荷されている。
# node:22 で入れると依存の読み込みに失敗することがあり、しかも n8n は
# その例外を握りつぶして Command "start" not found としか言わない。
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

# ★ start コマンドが実際に読み込めるかをビルド時に確かめる。
#   失敗したらビルドが落ちて、握りつぶされている本当のエラーが出る。
RUN node -e "try{require('/usr/local/lib/node_modules/n8n/dist/commands/start.js');console.log('OK start.js loaded')}catch(e){console.error('REAL ERROR:',e.message);console.error(e.stack);process.exit(1)}"


ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV N8N_PORT=10000
ENV PORT=10000
ENV N8N_USER_FOLDER=/data

RUN mkdir -p /data && chown -R node:node /data

EXPOSE 10000

USER node
CMD ["n8n"]
