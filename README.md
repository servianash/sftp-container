# sftp-container-gcs-sync
SFTP container to rsync data between local repository and GCS bucket

Works only if virtual machine which hosts container have permission to access container. This container will take Environment variable USERNAME AND BUCKET_NAME
AT THE TIME OF DOCKER RUN.

/usr/bin/docker run -d \
    -v /etc/ssh/sftp_user/ssh_host_ed25519_key.pub:/home/${username}/.ssh/keys/id_rsa.pub:ro \
    -v /etc/ssh/sftp_user/ssh_host_rsa_key.pub:/home/${username}/.ssh/keys/ssh_host_rsa_key.pub:ro \
    -v /etc/ssh/sftp_user/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key \
    -v /etc/ssh/sftp_user/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key \
    -v /home/sftp_user/upload:/home/${username}/upload \
    -e USERNAME=${username} \
    -e BUCKETNAME={bucketname} \
    -p 2222:22 \
    --name=sftp-container ${image} \
    ${username}::2000:::upload
