# syntax=docker/dockerfile:1

# The build produces browser files that run on either target architecture.
FROM --platform=$BUILDPLATFORM node:22-bookworm-slim AS build
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0 \
    YARN_ENABLE_TELEMETRY=0 \
    NODE_OPTIONS=--max-old-space-size=3072
RUN corepack enable
WORKDIR /src
COPY Octane-Renderer/ ./Octane-Renderer/
COPY Octane/ ./Octane/
RUN cd Octane-Renderer && yarn install --immutable
RUN cd Octane && yarn install --immutable && yarn build

FROM nginx:stable-alpine
COPY --from=build /src/Octane/dist/ /usr/share/nginx/html/
COPY Octane/LICENSE /usr/share/nginx/html/licenses/Octane.txt
COPY Octane-Renderer/LICENSE /usr/share/nginx/html/licenses/Octane-Renderer.txt
COPY docker/client/nginx.conf /etc/nginx/conf.d/default.conf
COPY --chmod=755 docker/client/entrypoint.sh /docker-entrypoint.d/40-octane-config.sh
