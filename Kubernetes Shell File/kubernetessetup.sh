cat <<EOF >> start.sh
# etcd
docker run                            \
  --net=host                          \
  -d                                  \
  gcr.io/google_containers/etcd:2.0.9 \
    /usr/local/bin/etcd               \
    --addr=127.0.0.1:4001             \
    --bind-addr=0.0.0.0:4001          \
    --data-dir=/var/etcd/data

# kubernetes
docker run                                     \
  --net=host                                   \
  -d                                           \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gcr.io/google_containers/hyperkube:v0.21.2   \
    /hyperkube                                 \
      kubelet                                  \
        --api_servers=http://localhost:8080    \
        --v=2                                  \
        --address=0.0.0.0                      \
        --enable_server                        \
        --hostname_override=127.0.0.1          \
        --config=/etc/kubernetes/manifests

# proxy
docker run                                   \
  -d                                         \
  --net=host                                 \
  --privileged                               \
  gcr.io/google_containers/hyperkube:v0.21.2 \
    /hyperkube                               \
      proxy                                  \
      --master=http://127.0.0.1:8080         \
      --v=2
EOF
cat <<EOF >> stop.sh
docker kill \`docker ps -aq\`
EOF

#START BY COPYING BELOW CODE
chmod 755 start.sh stop.sh



#RUN FOLLOWING
./start.sh




#COPY AND PASTE THE FOLOWING

cat <<EOF >> run_kubectl.sh
docker run \
  -ti \
  --net=host \
  tdeheurles/gcloud-tools:latest \
  bash
EOF
chmod 755 run_kubectl.sh
./run_kubectl.sh