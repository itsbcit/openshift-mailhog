FROM bcit/alpine:3.10
LABEL maintainer="chriswood.ca@gmail.com"
LABEL build_id="1574714825"

# Script to hash password from MAILHOG_PASS envvar to authfile
# and unconfigured outgoing smtp json file
COPY 50-create-authfile.sh 50-configure-outgoing-smtp.sh 99-wait-for-mongo.sh \
    /docker-entrypoint.d/
COPY outgoing-smtp.json /mailhog/

RUN adduser -D -u 1000 mailhog \
 && chown mailhog:root /mailhog \
 && chmod 774 /mailhog

# START Mailhog specifics from https://github.com/mailhog/MailHog/blob/master/Dockerfile
# Install ca-certificates, required for the "release message" feature:
RUN apk --no-cache add \
    ca-certificates

# Install MailHog:
RUN apk --no-cache add --virtual build-dependencies \
    go \
    git \
    musl-dev \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go get github.com/mailhog/MailHog \
  && mv /root/gocode/bin/MailHog /usr/local/bin \
  && rm -rf /root/gocode \
  && apk del --purge build-dependencies

USER mailhog
WORKDIR /home/mailhog
# END Mailhog specifics

CMD ["MailHog","-auth-file=/mailhog/authfile", "-outgoing-smtp=/mailhog/outgoing-smtp.json"]
EXPOSE 1025 8025
