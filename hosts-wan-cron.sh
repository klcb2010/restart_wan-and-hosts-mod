#!/bin/bash

# 定义目录和文件URL，使用ghproxy作为代理
BASE_URL="https://mirror.ghproxy.com/https://raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/"
DEST_DIR="/jffs/scripts/"  
CRONTAB_DIR="$DEST_DIR/crontabs/"  

# 创建目标目录（如果不存在）
mkdir -p "$DEST_DIR"
mkdir -p "$CRONTAB_DIR"

# 下载文件
curl -L -o "$DEST_DIR/copy_hosts.sh" "$BASE_URL/copy_hosts.sh"
curl -L -o "$DEST_DIR/restart_wan.sh" "$BASE_URL/restart_wan.sh"
curl -L -o "$DEST_DIR/set_crontab.sh" "$BASE_URL/set_crontab.sh"
curl -L -o "$CRONTAB_DIR/hosts" "$BASE_URL/hosts"
curl -L -o "$CRONTAB_DIR/klcb2010" "$BASE_URL/klcb2010"  # 添加下载klcb2010文件

# 赋予执行权限给shell脚本文件
chmod +x "$DEST_DIR/copy_hosts.sh"
chmod +x "$DEST_DIR/restart_wan.sh"
chmod +x "$DEST_DIR/set_crontab.sh"
chmod +x "$CRONTAB_DIR/klcb2010"  # 添加klcb2010的执行权限

# 运行 copy_hosts.sh
"$DEST_DIR/copy_hosts.sh"

# 运行 restart_wan.sh（请谨慎执行，因为它可能会重启你的WAN连接）
"$DEST_DIR/restart_wan.sh"

# 运行 set_crontab.sh，将klcb2010文件内容添加到crontab
"$DEST_DIR/set_crontab.sh" "$CRONTAB_DIR/klcb2010"  # 修改set_crontab.sh的参数，使其处理klcb2010文件

echo "文件已成功下载，并且相关脚本已运行。klcb2010文件已添加到crontab任务，并具有执行权限。"
