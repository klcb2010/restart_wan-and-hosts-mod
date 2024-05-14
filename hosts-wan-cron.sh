#!/bin/bash  
  
# 定义目录和文件URL，使用ghproxy作为代理  
BASE_URL="https://mirror.ghproxy.com/raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/"  
DEST_DIR="/jffs/scripts/"      
CRONTAB_FILE="$DEST_DIR/crontabs/klcb2010"  
  
# 创建目标目录（如果不存在）  
mkdir -p "$DEST_DIR"  
mkdir -p "$(dirname "$CRONTAB_FILE")"  
  
# 下载文件  
curl -L -o "$DEST_DIR/copy_hosts.sh" "$BASE_URL/copy_hosts.sh"  
curl -L -o "$DEST_DIR/restart_wan.sh" "$BASE_URL/restart_wan.sh"  
curl -L -o "$DEST_DIR/set_crontab.sh" "$BASE_URL/set_crontab.sh"  
curl -L -o "$CRONTAB_FILE" "$BASE_URL/klcb2010"  
  
# 检查文件是否成功下载  
for file in "$DEST_DIR/copy_hosts.sh" "$DEST_DIR/restart_wan.sh" "$DEST_DIR/set_crontab.sh" "$CRONTAB_FILE"; do  
    if [ ! -f "$file" ]; then  
        echo "Error: File $file was not downloaded successfully."  
        exit 1  
    fi  
done  
  
# 赋予执行权限给shell脚本文件  
chmod +x "$DEST_DIR/copy_hosts.sh"  
chmod +x "$DEST_DIR/restart_wan.sh"  
chmod +x "$DEST_DIR/set_crontab.sh"  
  
# 设置crontab文件的合适权限（仅所有者可读写）  
chmod 600 "$CRONTAB_FILE"  
  
# 运行 copy_hosts.sh  
"$DEST_DIR/copy_hosts.sh"  
  
# 运行 restart_wan.sh（请谨慎执行，因为它可能会重启您的WAN连接）  
"$DEST_DIR/restart_wan.sh"  
  
# 运行 set_crontab.sh 以更新crontab（确保set_crontab.sh脚本正确实现此功能）  
"$DEST_DIR/set_crontab.sh"  
  
echo "文件已成功下载，并且相关脚本已运行。klcb2010文件的权限已被设置为600。"
