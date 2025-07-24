FROM barichello/godot-ci:4.4.1 AS builder

WORKDIR /app

COPY . .

ENV XDG_RUNTIME_DIR=/tmp

RUN mkdir -p dist
RUN godot --headless --export-release "Web" dist/index.html

FROM nginx:alpine AS runner

ARG VERSION

ENV APP_VERSION=$VERSION

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist/ /usr/share/nginx/html/

EXPOSE 8080