#!/bin/bash
crontab -l | { cat; echo "$CRONTIME /etc/gcs_scripts/mv_sftp_data.sh"; } | crontab -
cron
exec /entrypoint "$@"