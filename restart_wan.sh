#!/bin/bash  
  
# 脚本版本信息  
SCRIPT_VERSION="1.0"  
  
# 日志文件路径  
LOG_FILE="/jffs/scripts/wan_log.log"  
TMP_LOG_FILE="/jffs/scripts/wan_log.tmp"  
  
# 获取当前日期  
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")  
  
# 计算七天前的日期  
current_timestamp=$(date +%s)  
days_to_subtract=$((7 * 86400))  # 7天转换为秒  
cutoff_timestamp=$((current_timestamp - days_to_subtract))  
cutoff_date=$(date -d @$cutoff_timestamp +%Y-%m-%d)  
  
# 使用awk保留最近七天的记录  
awk -v date="$cutoff_date" '  
    {  
        match($0, /\[[^\]]+\]/, arr)  
        log_date=gensub(/\[|\]/, "", "g", arr[0])  
        split(log_date, date_parts, " ")  
        if (date_parts[1] >= date) print  
    }  
' "$LOG_FILE" > "$TMP_LOG_FILE" && mv "$TMP_LOG_FILE" "$LOG_FILE"  
  
# 检查awk命令是否成功执行  
if [ $? -eq 0 ]; then  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - Log file truncated to last 7 days." >> "$LOG_FILE"  
else  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - Failed to truncate log file." >> "$LOG_FILE"  
fi  
  
# 重启WAN服务  
echo "[$CURRENT_DATE $SCRIPT_VERSION] - Restarting WAN service..." >> "$LOG_FILE"  
if service restart_wan; then  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - WAN service restarted successfully." >> "$LOG_FILE"  
else  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - Failed to restart WAN service." >> "$LOG_FILE"  
    exit 1  # 重启失败，退出脚本并返回错误码  
fi  
  
# 脚本结束  
exit 0
