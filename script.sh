gcloud compute instances create golubec \
    --zone=us-central1-c \
    --machine-type=n2-standard-4 \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-balanced \
    --tags=http-server,https-server \
    --address=35.208.193.205 \
    --subnet=default \
    --disk=name=disk-1,boot=no \
    --can-ip-forward \
    --network-tier=STANDARD

    gcloud compute instances add-metadata golubec \
  --metadata key=value --zone=us-central1-c

  gcloud compute instances detach-disk golubec --disk=disk-1 --zone=us-central1-c && gcloud compute instances delete golubec --zone=us-central1-c --quiet 


  apt install oathtool qrencode