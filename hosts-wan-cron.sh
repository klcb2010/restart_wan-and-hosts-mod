#!/bin/bash  
  
# 定义目录和文件URL  
BASE_URL="https://mirror.ghproxy.com/raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/"  
DEST_DIR_SCRIPTS="/jffs/scripts/"  
DEST_DIR_CRONTABS="$DEST_DIR_SCRIPTS/crontabs/"  
  
# 创建目标目录（如果不存在）  
mkdir -p "$DEST_DIR_SCRIPTS"  
mkdir -p "$DEST_DIR_CRONTABS"  
  
# 下载文件并记录日志  
function download_file {  
    local url=$1  
    local dest=$2  
    curl -L -o "$dest" "$url" || {  
        echo "Error: Failed to download $url to $dest"  
        exit 1  
    }  
    echo "Downloaded $url to $dest"  
}  
  
download_file "$BASE_URL/copy_hosts.sh" "$DEST_DIR_SCRIPTS/copy_hosts.sh"  
download_file "$BASE_URL/restart_wan.sh" "$DEST_DIR_SCRIPTS/restart_wan.sh"  
download_file "$BASE_URL/set_crontab.sh" "$DEST_DIR_SCRIPTS/set_crontab.sh"  
download_file "$BASE_URL/klcb2010" "$DEST_DIR_CRONTABS/klcb2010"  
  
# 赋予执行权限给shell脚本文件  
chmod +x "$DEST_DIR_SCRIPTS/copy_hosts.sh"  
chmod +x "$DEST_DIR_SCRIPTS/restart_wan.sh"  
chmod +x "$DEST_DIR_SCRIPTS/set_crontab.sh"  
  
# 执行脚本并记录日志  
function execute_script {  
    local script=$1  
    echo "Executing $script..."  
    "$script" || {  
        echo "Error: $script failed with exit code $?"  
        exit 1  
    }  
    echo "$script executed successfully."  
}  
  
execute_script "$DEST_DIR_SCRIPTS/copy_hosts.sh"  
  
# 重启WAN连接的脚本，请谨慎使用  
# execute_script "$DEST_DIR_SCRIPTS/restart_wan.sh"  # 取消注释以执行  
  
execute_script "$DEST_DIR_SCRIPTS/set_crontab.sh"  
  
echo "All scripts executed successfully."
