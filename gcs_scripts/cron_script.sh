#!/bin/bash
# Dump environment variables to file to cronscript to pickup
ENV_VARS_FILE="/etc/profile"
echo "Dumping env variables into ${ENV_VARS_FILE}"
eval $(printenv | awk -F= '{print "export " "\""$1"\"""=""\""$2"\"" }' >> $ENV_VARS_FILE)
chmod +x $ENV_VARS_FILE

crontab -l | { cat; echo "$CRONTIME /etc/gcs_scripts/mv_sftp_data.sh"; } | crontab -
cron
exec /entrypoint "$@"