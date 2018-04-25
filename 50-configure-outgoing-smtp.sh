sed -i "s/#SMTPOUT_SERVERNAME/$SMTPOUT_SERVERNAME/g" /mailhog/outgoing-smtp.json
sed -i "s/#SMTPOUT_HOST/$SMTPOUT_HOST/" /mailhog/outgoing-smtp.json
sed -i "s/#SMTPOUT_PORT/$SMTPOUT_PORT/" /mailhog/outgoing-smtp.json