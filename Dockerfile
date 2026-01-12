# Render等で動かすための設定
FROM docker.n8n.io/n8nio/n8n:latest

# 1. 権限をrootに切り替える
USER root

# 2. ツールをインストール（apk ではなく apt-get を使います）
# updateしてから install するのがお作法です
RUN apt-get update && apt-get install -y poppler-utils python3

# 3. ポート設定
ENV PORT=10000
EXPOSE 10000

# 4. ユーザーをnodeに戻す
USER node
