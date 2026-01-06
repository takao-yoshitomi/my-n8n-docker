FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Renderのデフォルトポート10000に対応
ENV PORT=10000
EXPOSE 10000

# 念のため、起動時にポートを上書きするように設定
CMD ["n8n", "start"]
