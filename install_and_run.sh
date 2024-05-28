#!/bin/bash

# 日志文件路径
log_file="/jffs/scripts/install_and_run.log"

# 记录脚本开始时间
start_time=$(date +'%Y-%m-%d %H:%M:%S')
echo "[$start_time] Script execution started." >> "$log_file"

# 1. 下载 hosts-wan-cron.sh 脚本
curl_output=$(curl -L -o /jffs/scripts/hosts-wan-cron.sh "https://mirror.ghproxy.com/raw.githubusercontent.com/klcb2010/restart_wan-and-hosts-mod/main/hosts-wan-cron.sh")
curl_status=$?

# 记录下载操作的日志
if [ $curl_status -eq 0 ]; then
    end_time=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[$end_time] Download of hosts-wan-cron.sh successful." >> "$log_file"
else
    end_time=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[$end_time] Error downloading hosts-wan-cron.sh: $curl_output" >> "$log_file"
    exit 1
fi

# 2. 赋予 hosts-wan-cron.sh 脚本执行权限
chmod_output=$(chmod 777 /jffs/scripts/hosts-wan-cron.sh)
chmod_status=$?

# 记录赋予权限操作的日志
if [ $chmod_status -eq 0 ]; then
    end_time=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[$end_time] Successfully granted execute permissions to hosts-wan-cron.sh." >> "$log_file"
else
    end_time=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[$end_time] Error granting execute permissions to hosts-wan-cron.sh: $chmod_output" >> "$log_file"
    exit 1
fi

# 3. 执行 hosts-wan-cron.sh 脚本两次
for i in {1..2}
do
    cron_output=$(/jffs/scripts/hosts-wan-cron.sh)
    cron_status=$?

    # 记录执行操作的日志
    if [ $cron_status -eq 0 ]; then
        end_time=$(date +'%Y-%m-%d %H:%M:%S')
        echo "[$end_time] Execution of hosts-wan-cron.sh attempt $i was successful." >> "$log_file"
    else
        end_time=$(date +'%Y-%m-%d %H:%M:%S')
        echo "[$end_time] Error executing hosts-wan-cron.sh on attempt $i: $cron_output" >> "$log_file"
    fi
done

# 记录脚本结束时间
end_time=$(date +'%Y-%m-%d %H:%M:%S')
echo "[$end_time] Script execution completed." >> "$log_file"

# 脚本结束
exit 0
