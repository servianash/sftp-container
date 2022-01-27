FROM atmoz/sftp
# Install gcloudutil so we can mount GCS buckets
# Ref: https://cloud.google.com/sdk/docs/install
ENV USERNAME test
ENV BUCKETNAME bucket
ENV CRONTIME "* 1 * * *"
RUN apt-get update
RUN apt-get install -y curl gnupg wget lsb-release cron sudo
RUN apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install google-cloud-sdk

RUN mkdir -p /etc/gcs_scripts
ADD ./gcs_scripts/cron_script.sh /etc/gcs_scripts/cron_script.sh
ADD ./gcs_scripts/mv_sftp_data.sh /etc/gcs_scripts/mv_sftp_data.sh

RUN chmod +x /etc/gcs_scripts/*

# set to run our script
ENTRYPOINT [ "/etc/gcs_scripts/cron_script.sh" ]