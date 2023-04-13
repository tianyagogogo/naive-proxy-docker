FROM golang:alpine AS build

RUN go version \
    && go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

WORKDIR /go

RUN xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive

FROM caddy:alpine AS final

COPY --from=build /go/caddy /usr/bin/caddy
