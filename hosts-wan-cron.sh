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
  
# 赋予执行权限给shell脚本文件  
chmod +x "$DEST_DIR/copy_hosts.sh"  
chmod +x "$DEST_DIR/restart_wan.sh"  
chmod +x "$DEST_DIR/set_crontab.sh"  
  
# 注意：以下命令将运行这些脚本。确保它们没有潜在的安全风险。  
# 你可以根据需要添加任何必要的参数或环境变量。  
  
# 运行 copy_hosts.sh  
"$DEST_DIR/copy_hosts.sh"  
  
# 运行 restart_wan.sh（请谨慎执行，因为它可能会重启你的WAN连接）  
"$DEST_DIR/restart_wan.sh"  
  
# 运行 set_crontab.sh（这可能会修改cron作业，所以请谨慎）  
"$DEST_DIR/set_crontab.sh"  
  
echo "文件已成功下载，并且相关脚本已运行。"
