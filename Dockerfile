# n8n 本体は公式イメージをそのまま使う。
# node:alpine に npm install -g n8n@... する方式は、ベースイメージと npm が
# 更新されると同じバージョンを再現できなくなる（2026-11-08 に実際に壊れた）。
FROM n8nio/n8n:2.14.2

# 1. 必要ツール（apk を叩くので一時的に root へ）
# font-noto-cjk: 日本語フォントの実体
# poppler-utils: pdftoppm。★1-2 が PDF を JPEG にするのに使う
USER root
RUN apk add --no-cache \
    imagemagick \
    poppler-utils \
    poppler-data \
    font-noto-cjk \
    bash \
    graphicsmagick

# 2. n8n のインストールは不要になった（公式イメージに入っている）
#    python3 / py3-setuptools / make / g++ も不要。ネイティブビルドをしないため

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
#    ★CMD は書かないこと。公式イメージは ENTRYPOINT で n8n を起動する。
#      ここで CMD ["n8n"] と書くと `n8n n8n` になって起動に失敗する。
USER node
