# 1. 変更点: 末尾に "-debian" をつけて、中身がDebian版であることを指定します
FROM docker.n8n.io/n8nio/n8n:latest-debian

# 2. 権限をrootに切り替える
USER root

# 3. これで確実に apt-get が動きます
RUN apt-get update && apt-get install -y poppler-utils python3

# 4. ポート設定（Render用）
ENV PORT=10000
EXPOSE 10000

# 5. ユーザーをnodeに戻す
USER node
