FROM node:20.11-alpine

# 1. 必要ツール
# font-noto-cjk: ★これを追加！日本語フォントの実体です
# imagemagick: 画像処理ツールを追加しました
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

# 2. n8n インストール 最新の安定版へ　R8.4.4
RUN npm install -g n8n@2.14.2 --omit=dev --legacy-peer-deps

# 3. Codeノードの制限解除
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*

# 4. n8n設定
ENV N8N_PORT=10000
ENV PORT=10000
ENV N8N_USER_FOLDER=/data

# 5. データ保存用ディレクトリ
RUN mkdir -p /data && chown -R node:node /data

EXPOSE 10000

# 6. 実行
USER node
CMD ["n8n"]
