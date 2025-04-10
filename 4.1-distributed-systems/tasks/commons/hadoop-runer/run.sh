mkdir -p ./.hadoop
mkdir -p ./.hadoop/data
mkdir -p ./.hadoop/user

podman run -d --name hadoop-container \
  -p 8088:8088 \
  -p 9870:9870 \
  -v ./.hadoop/data:/usr/src/app/hadoop-3.4.1/data \
  -v ./.hadoop/user:/root \
  hadoop
