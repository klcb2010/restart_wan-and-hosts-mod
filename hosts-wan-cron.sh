#!/bin/bash  
  
# 定义目录和文件URL  
BASE_URL="https://raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/"  
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
  
# 赋予执行权限给shell脚本文件  
chmod +x "$DEST_DIR/copy_hosts.sh"  
chmod +x "$DEST_DIR/restart_wan.sh"  
chmod +x "$DEST_DIR/set_crontab.sh"  
  
# 注意：以下命令将hosts文件设置为777权限，这通常是不安全的  
# 但如果你确实需要这样做，请确保你了解潜在的安全风险  
chmod 777 "$CRONTAB_DIR/hosts"  
  
echo "文件已成功下载并放置到指定目录。"
