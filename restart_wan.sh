#!/bin/bash

# 脚本版本信息
SCRIPT_VERSION="1.1"
RUN_DATE=$(date +"%Y-%m-%d")

# 设置日志文件路径
LOG_FILE="/jffs/scripts/restart_wan.log"

# 获取当前日期的日部分
CURRENT_DAY=$(date +"%d")

# 检查当前日期是否为偶数
if ((CURRENT_DAY % 2 == 0)); then
    # 如果是偶数日期，则执行以下操作
    echo "[$RUN_DATE $SCRIPT_VERSION] - Starting restart_wan.sh on even day" >> "$LOG_FILE"

    # 执行重启命令，并将输出也记录到日志中
    echo "[$RUN_DATE $SCRIPT_VERSION] - Executing service restart_wan..." >> "$LOG_FILE"
    if [[ $(service restart_wan > /dev/null 2>&1) == 0 ]]; then
        echo "[$RUN_DATE $SCRIPT_VERSION] - Service restart_wan restarted successfully on even day" >> "$LOG_FILE"
    else
        echo "[$RUN_DATE $SCRIPT_VERSION] - Failed to restart service restart_wan on even day" >> "$LOG_FILE"
    fi

    # 写入执行结束的日志
    echo "[$RUN_DATE $SCRIPT_VERSION] - Finished restart_wan.sh on even day" >> "$LOG_FILE"
else
    # 如果不是偶数日期，则记录日志但不执行重启
    echo "[$RUN_DATE $SCRIPT_VERSION] - Skipping restart_wan.sh on odd day" >> "$LOG_FILE"
fi

# 删除超过 7 天的日志文件
find /path/to/logs -type f -mtime +7 -exec rm -rf {} \;
