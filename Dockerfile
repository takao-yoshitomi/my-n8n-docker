FROM node:20-alpine

# 1. 必要ツール（★ここに poppler-data を追加！）
# poppler-data: これがないと中身が日本語のPDFは変換できません
RUN apk add --no-cache \
  poppler-utils \
  poppler-data \
  python3 \
  bash

# 2. n8n インストール
RUN npm install -g n8n --omit=dev --legacy-peer-deps

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
