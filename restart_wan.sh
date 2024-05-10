#!/bin/bash  
  
# 脚本版本信息  
SCRIPT_VERSION="1.1"  
  
# 设置日志文件路径  
LOG_FILE="/jffs/scripts/restart_wan.log"  
TMP_LOG_FILE="/jffs/scripts/restart_wan.log.tmp"  
  
# 获取当前日期  
CURRENT_DATE=$(date +"%Y-%m-%d")  
  
# 计算七天前的日期  
SEVEN_DAYS_AGO=$(date --date="7 days ago" +"%Y-%m-%d")  
  
# 使用awk保留最近七天的记录  
# 假设每条日志记录的日期时间戳格式是 [YYYY-MM-DD HH:MM:SS]  
awk -v date="$SEVEN_DAYS_AGO" '  
    BEGIN {  
        flag = 0  
    }  
    # 如果遇到新的日期时间戳并且它大于或等于七天前的日期，设置flag为1  
    /\[[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}\]/ {  
        if (substr($0, 2, 10) >= date) {  
            flag = 1  
        }  
    }  
    # 如果flag为1，则打印当前行（即保留该记录）  
    flag  
' "$LOG_FILE" > "$TMP_LOG_FILE"  
  
# 检查awk命令是否成功执行  
if [ $? -eq 0 ]; then  
    # 如果成功，用处理后的日志替换原始日志  
    mv "$TMP_LOG_FILE" "$LOG_FILE"  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - Log file truncated to last 7 days." >> "$LOG_FILE"  
  
    # 重启WAN服务的代码  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - Restarting WAN service..." >> "$LOG_FILE"  
    # 假设重启WAN服务的命令是 service restart_wan  
    if service restart_wan; then  
        echo "[$CURRENT_DATE $SCRIPT_VERSION] - WAN service restarted successfully." >> "$LOG_FILE"  
    else  
        echo "[$CURRENT_DATE $SCRIPT_VERSION] - Failed to restart WAN service." >> "$LOG_FILE"  
    fi  
else  
    echo "[$CURRENT_DATE $SCRIPT_VERSION] - Failed to truncate log file." >> "$LOG_FILE"  
fi  
  
# 如果需要，您可以添加额外的日志记录或清理步骤  
  
# 脚本结束  
exit 0
