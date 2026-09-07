FROM ruby:3.0.2

ENV LANG C.UTF-8
ENV DEBCONF_NOWARNINGS yes
ENV XDG_CACHE_HOME /tmp

ARG NODE_VERSION=14.16.1
# BuildKit がビルド先アーキテクチャ（amd64 / arm64）を自動で入れる。
# 未設定の環境では x64 とみなす（下の case 参照）
ARG TARGETARCH

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential vim less xz-utils && \
    rm -rf /var/lib/apt/lists/*

# deb.nodesource.com / dl.yarnpkg.com の旧 apt リポジトリは署名鍵が失効しており
# `apt install nodejs yarn` がビルドを止めるため、Node は公式配布物から、
# yarn は npm 経由で導入する（.node-version と同じ 14.16.1）
RUN NODE_ARCH="$(case "${TARGETARCH}" in arm64) echo arm64 ;; *) echo x64 ;; esac)" && \
    curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" -o /tmp/node.tar.xz && \
    tar -xJf /tmp/node.tar.xz -C /usr/local --strip-components=1 && \
    rm /tmp/node.tar.xz && \
    npm install -g yarn

WORKDIR /myapp
COPY . ./
RUN bundle
RUN yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
