#!/bin/bash  
  
# 定义目录和文件URL  
BASE_URL="https://mirror.ghproxy.com/raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/"  
DEST_DIR_SCRIPTS="/jffs/scripts/"  
DEST_DIR_CRONTABS="$DEST_DIR_SCRIPTS/crontabs/"  
  
# 创建目标目录（如果不存在）  
mkdir -p "$DEST_DIR_SCRIPTS"  
mkdir -p "$DEST_DIR_CRONTABS"  
  
# 下载文件  
curl -L -o "$DEST_DIR_SCRIPTS/copy_hosts.sh" "$BASE_URL/copy_hosts.sh"  
curl -L -o "$DEST_DIR_SCRIPTS/restart_wan.sh" "$BASE_URL/restart_wan.sh"  
curl -L -o "$DEST_DIR_SCRIPTS/set_crontab.sh" "$BASE_URL/set_crontab.sh"  
curl -L -o "$DEST_DIR_CRONTABS/klcb2010" "$BASE_URL/klcb2010"  
  
# 检查文件是否成功下载  
for file in "$DEST_DIR_SCRIPTS/copy_hosts.sh" "$DEST_DIR_SCRIPTS/restart_wan.sh" "$DEST_DIR_SCRIPTS/set_crontab.sh" "$DEST_DIR_CRONTABS/klcb2010"; do  
    if [ ! -f "$file" ]; then  
        echo "Error: File $file was not downloaded successfully."  
        exit 1  
    fi  
done  
  
# 赋予执行权限给shell脚本文件  
chmod +x "$DEST_DIR_SCRIPTS/copy_hosts.sh"  
chmod +x "$DEST_DIR_SCRIPTS/restart_wan.sh"  
chmod +x "$DEST_DIR_SCRIPTS/set_crontab.sh"  
  
# 注意：klcb2010 似乎是一个 crontab 文件，因此不需要执行权限  
  
# 执行脚本（请谨慎操作，特别是restart_wan.sh）  
echo "Executing copy_hosts.sh..."  
"$DEST_DIR_SCRIPTS/copy_hosts.sh"  
  
# 如果您想要执行 restart_wan.sh，请取消下面的注释，但请谨慎操作  
echo "Executing restart_wan.sh..."  
"$DEST_DIR_SCRIPTS/restart_wan.sh"  
  
echo "Executing set_crontab.sh..."  
"$DEST_DIR_SCRIPTS/set_crontab.sh"  
  
# 假设 set_crontab.sh 是用来设置 crontab 的，并且它使用 klcb2010 文件作为输入  
# 您可能需要在 set_crontab.sh 脚本中指定正确的 crontab 文件路径  
  
echo "Scripts executed successfully."
