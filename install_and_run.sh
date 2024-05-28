#!/bin/bash

# 定义日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> /jffs/scripts/execution.log
}

# 下载脚本并记录日志
log "Downloading hosts-wan-cron.sh..."
curl -L -o /jffs/scripts/hosts-wan-cron.sh https://mirror.ghproxy.com/raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/hosts-wan-cron.sh
if [ $? -eq 0 ]; then
    log "Download successful."
else
    log "Download failed."
    exit 1
fi

# 设置执行权限并记录日志
log "Granting execute permissions to hosts-wan-cron.sh..."
chmod 777 /jffs/scripts/hosts-wan-cron.sh
if [ $? -eq 0 ]; then
    log "Permissions granted successfully."
else
    log "Failed to grant permissions."
    exit 1
fi

# 运行 hosts-wan-cron.sh 两次并记录日志
for i in {1..2}; do
    log "Running hosts-wan-cron.sh attempt $i..."
    /jffs/scripts/hosts-wan-cron.sh
    if [ $? -eq 0 ]; then
        log "hosts-wan-cron.sh attempt $i was successful."
    else
        log "hosts-wan-cron.sh attempt $i failed."
    fi
done

# 运行 set_crontab.sh 两次并记录日志
for i in {1..2}; do
    log "Running set_crontab.sh attempt $i..."
    /jffs/scripts/set_crontab.sh
    if [ $? -eq 0 ]; then
        log "set_crontab.sh attempt $i was successful."
    else
        log "set_crontab.sh attempt $i failed."
    fi
done

log "Script execution completed."
