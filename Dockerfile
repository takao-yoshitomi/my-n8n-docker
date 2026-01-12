# 1. ここを変える！「n8n公式」ではなく「Node.jsのAlpine版」を土台にする
FROM node:20-alpine

# 2. Alpineなので apk が確実に動く
RUN apk add --no-cache poppler-utils python3

# 3. n8n を手動でインストール（公式イメージじゃないので自分で入れる）
RUN npm install -g n8n

# 4. ポート設定（Renderの環境変数設定と一致させる）
ENV N8N_PORT=10000
ENV PORT=10000
EXPOSE 10000

# 5. 実行
USER node
CMD ["n8n"]
