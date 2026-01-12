# Render等で動かすための軽量設定
FROM docker.n8n.io/n8nio/n8n:latest

# 1. 権限をrootに切り替えてツールをインストール
USER root

# 2. PDF変換ツール(poppler-utils)とPython3を入れる
RUN apk add --no-cache poppler-utils python3

# 3. ポート設定（Render等の仕様に合わせる）
ENV PORT=10000
EXPOSE 10000

# 4. セキュリティのためユーザーをnodeに戻す
USER node
