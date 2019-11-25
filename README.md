# mailhog OpenShift image

## Labels

See [Docker Cloud](https://hub.docker.com/repository/docker/bcit/openshift-mailhog/tags) for full listing but the main ones are:

* [`latest`](https://github.com/itsbcit/openshift-mailhog/blob/master/Dockerfile)

## Default Behavior

Runs mailhog with in memory storage.

- Runs smtp on 1025
- Runs WebUI on 8025

```bash
docker pull bcit/openshift-php-fpm
docker run -it -u 100000 -p 8025:8025 -p 1025:1025 bcit/openshift-php-fpm
```

## Configure openshift-mailhog
Sample Config
| Environment Var | Value | Description
| --------------- | ----- | -----------
| MAILHOG_PASS    | myPassword |
| MH_HOSTNAME	    | mailhog.internal.website |
| MH_STORAGE      | mongodb | use external mongo server
| MH_MONGO_URI	  | mongo:27017 |
| SMTPOUT_HOST	  | haraka-mail-forwarding.internal.svc | relay off another mail server that supports auth
| SMTPOUT_PORT	  | 1025 |
| SMTPOUT_SERVERNAME	ourMailRelay |

### Mailhog Environmental Variables
See here for all options: https://github.com/mailhog/MailHog/blob/master/docs/CONFIG.md

### openshift-mailhog Environmental Variables
| Environment Var | Description
| --------------- | ------------
| MAILHOG_PASS    | Password to secure the web UI
| SMTPOUT_HOST    | Outgoing SMTP hostname (Used to pre-define option in web UI)
| SMTPOUT_PORT    | Outgoing SMTP port (Used to pre-define option in web UI)
| SMTPOUT_SERVERNAME | Outgoing SMTP name  (Used to pre-define option in web UI)
