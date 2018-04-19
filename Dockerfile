FROM mailhog/mailhog

ENV RUNUSER none
ENV HOME /

USER root
WORKDIR /

RUN apk add --no-cache \
        tini

# Add docker-entrypoint script base
ENV DE_VERSION v1.0
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/${DE_VERSION}/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz \
    && chmod -R 555 /docker-entrypoint.*


# Allow resolve-userid.sh script to run
RUN chmod 664 /etc/passwd /etc/group

COPY 50-create-authfile.sh /docker-entrypoint.d/
RUN mkdir /mailhog \
    && chmod 474 /mailhog

USER mailhog
WORKDIR /home/mailhog

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
CMD ["MailHog","-auth-file=/mailhog/authfile"]