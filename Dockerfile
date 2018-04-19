FROM bcit/alpine

# Script to hash password from MAILHOG_PASS envvar to authfile
COPY 50-create-authfile.sh /docker-entrypoint.d/
RUN mkdir /mailhog \
    && chown root:root /mailhog \
    && chmod 474 /mailhog

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

RUN adduser -D -u 1000 mailhog
USER mailhog
WORKDIR /home/mailhog
# END Mailhog specifics

CMD ["MailHog","-auth-file=/mailhog/authfile"]
EXPOSE 1025 8025