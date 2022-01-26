#!/bin/bash
if ! crontab -l | grep -q "$CRONTIME /etc/gcs_scripts/mv_sftp_data.sh" ; then
    echo 'cron does not exists'
    crontab -l | { cat; echo "$CRONTIME /etc/gcs_scripts/mv_sftp_data.sh"; } | crontab -
else
    echo 'entry exists'
fi
cron
/bin/bash