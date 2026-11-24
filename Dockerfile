FROM alpine:3.23@sha256:469c9ea410b9215eaee7976ba6c0639039b444be8e5d638f7abbada189971eb2

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]

RUN apk add --no-cache --update cloc \
    dumb-init \
    git 

COPY entrypoint.sh /
