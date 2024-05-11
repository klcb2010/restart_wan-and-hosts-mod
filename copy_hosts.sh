#!/bin/bash  
  
# 源文件路径  
source_file="/jffs/scripts/hosts"  
  
# 目标文件路径  
target_file="/tmp/etc/hosts"  
  
# 日志文件路径  
log_file="/jffs/scripts/copy_hosts.log"  
TMP_LOG_FILE="/jffs/scripts/copy_hosts.tmp"  
  
# 检查日志文件是否存在，如果不存在则创建并设置权限  
if [ ! -f "$log_file" ]; then  
    touch "$log_file"  
    chmod 777 "$log_file"  
    echo "Log file $log_file created and permissions set to 777." >> "$log_file"  
fi  
  
# 计算七天前的日期  
current_timestamp=$(date +%s)  
days_to_subtract=$((7 * 86400))  
cutoff_timestamp=$((current_timestamp - days_to_subtract))  
cutoff_date=$(date -d @$cutoff_timestamp +%Y-%m-%d)  
  
# 保留最近七天的日志记录  
awk -v cutoff_date="$cutoff_date" '  
    {  
        # 假设时间戳位于每行的开始，格式为"YYYY-MM-DD HH:MM:SS"  
        match($0, /^([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}).*/, arr);  
        if (arr[1] >= cutoff_date) print;  
    }  
' "$log_file" > "$TMP_LOG_FILE" && mv "$TMP_LOG_FILE" "$log_file"  
  
# 检查源文件是否存在  
if [ ! -f "$source_file" ]; then  
    echo "Error: Source file $source_file does not exist." >> "$log_file"  
    exit 1  
fi  
  
# 使用cp命令覆盖目标文件  
cp -f "$source_file" "$target_file"  
  
# 检查操作是否成功  
if [ $? -eq 0 ]; then  
    echo "File $source_file has been copied to $target_file successfully." >> "$log_file"  
  
    # 现在修改ss_rule_update.sh中的URL_MAIN变量  
    sed -i 's#^URL_MAIN.*#URL_MAIN="https://mirror.ghproxy.com/https%3A%2F%2Fraw.githubusercontent.com%2Fqxzg%2FActions%2F3.0%2Ffancyss_rules"#g' /koolshare/scripts/ss_rule_update.sh  
  
    # 检查sed操作（这里只是简单地打印消息到日志）  
    echo "URL_MAIN in ss_rule_update.sh has been updated." >> "$log_file"  
else  
    echo "Error occurred while copying the file." >> "$log_file"  
    exit 1  
fi  
  
# 记录脚本结束时间（Unix 时间戳）  
end_timestamp=$(date +%s)  
echo "Script ended at $(date +%Y-%m-%d_%H:%M:%S)" >> "$log_file"  
  
# 计算运行时间（秒）  
duration=$((end_timestamp - start_timestamp))  
echo "Script ran for $duration seconds." >> "$log_file"
  
# 脚本结束  
exit 0
