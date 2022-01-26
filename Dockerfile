FROM atmoz/sftp
# Install gcloudutil so we can mount GCS buckets
# Ref: https://cloud.google.com/sdk/docs/install
ENV USERNAME test
ENV BUCKETNAME bucket

RUN apt-get update
RUN apt-get install -y curl gnupg wget lsb-release
RUN apt-get install -y apt-transport-https ca-certificates gnupg

# RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# RUN apt-get update && apt-get install google-cloud-sdk

RUN echo "deb http://packages.cloud.google.com/apt gcsfuse-stretch main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN cat /etc/apt/sources.list.d/gcsfuse.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y gcsfuse

# docker run -e USERNAME=username --env BUCKETNAME=bucketname
CMD [ "gcsfuse", "-o", "nonempty", "--only-dir", "$USERNAME", "$BUCKETNAME", "/home/$USERNAME/upload" ]