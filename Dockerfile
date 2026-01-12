# ベースイメージ
FROM node:20-alpine

# 1. 必要なツールをインストール
RUN apk add --no-cache poppler-utils python3

# 2. n8nをインストール
RUN npm install -g n8n --omit=dev --legacy-peer-deps

# 3. ★ここが修正ポイント！★
# 作業用のフォルダ /files を作成し、権限を「誰でも読み書きOK (777)」にします
RUN mkdir -p /files && chmod 777 /files

# 4. ポート設定
ENV N8N_PORT=10000
ENV PORT=10000
EXPOSE 10000

# 5. 実行ユーザー
USER node
CMD ["n8n"]
