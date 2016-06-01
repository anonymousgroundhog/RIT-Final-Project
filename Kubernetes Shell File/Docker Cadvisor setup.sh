docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=3000:3000 \
  --detach=true \
  --name=cadvisor2 \
  google/cadvisor:latest