#!/bin/bash

# 安装所需的软件
sudo apt-get update
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev

# 克隆 xmrig 代码
git clone https://github.com/xmrig/xmrig.git

# 进入 xmrig 目录并构建
cd xmrig || exit 1
mkdir -p build && cd build || exit 1
cmake ..
make -j4

# 创建配置文件 config.json
cat << EOF > config.json
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "coin": "monero",
            "algo": "rx/0",
            "url": "stratum-eu.rplant.xyz:17084",
            "user": "FM9VeF7jvEMxUPpdgKHLeLrFdRhN5atf5o",
            "pass": "kusa",
            "tls": false,
            "keepalive": true,
            "nicehash": false
        }
    ]
}
EOF

# 使用 tmux 运行 xmrig
tmux new -d -s xmrig './xmrig'
