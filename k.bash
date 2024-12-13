#!/bin/bash

# 安装所需的软件
sudo apt-get update
sudo apt-get install -y wget build-essential tar

# 下载和安装 WildRig Multi
WILDRIG_VERSION="0.36.7"
wget https://github.com/andru-kun/wildrig-multi/releases/download/$WILDRIG_VERSION/wildrig-multi-linux-$WILDRIG_VERSION.tar.xz
if [ $? -ne 0 ]; then
    echo "下载失败，请检查版本号或网络连接。"
    exit 1
fi
mkdir -p wildrig && tar -xvf wildrig-multi-linux-$WILDRIG_VERSION.tar.xz -C wildrig --strip-components 1

# 创建配置文件 run.sh
cat << EOF > run.sh
#!/bin/bash
./wildrig-multi --algo ghostrider \\
  --url eu.miningpower.eu:22161 \\
  --user FS432tmzwmrhKoQVKx5Vxaa7hvrmQXvuNM \\
  --pass kusa \\
  --keepalive
EOF

chmod +x run.sh

# 使用 tmux 运行 WildRig Multi
tmux new -d -s wildrig './run.sh'
