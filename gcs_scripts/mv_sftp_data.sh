#!/bin/bash
rm -rf /home/$USERNAME/upload/.ssh
gsutil mv /home/$USERNAME/upload gs://$BUCKETNAME