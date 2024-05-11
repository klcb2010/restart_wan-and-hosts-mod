#!/bin/sh  
  
# cron  
USER="klcb2010"  
  
#  
LOG_FILE="/jffs/scripts/set_crontab.log"  
  
#  
echo "$(date): set_crontab.sh start" >> "$LOG_FILE"  
  
# cron  
CRON_FILE="/jffs/scripts/crontabs/klcb2010"  
CRONTAB_FILE="/var/spool/cron/crontabs/$USER"  
  
# 检查CRON_FILE是否存在，如果不存在则尝试创建  
if [ ! -f "$CRON_FILE" ]; then  
    # 注意：通常不推荐直接创建crontab文件并设置777权限  
    # 但如果您确实需要这样做，请确保您知道潜在的安全风险  
    touch "$CRON_FILE"  
    if [ $? -eq 0 ]; then  
        echo "$(date): Cron tasks file $CRON_FILE has been created." >> "$LOG_FILE"  
        # 设置文件权限（不推荐使用777，除非您完全清楚为什么需要这样做）  
        chmod 777 "$CRON_FILE"  
        if [ $? -eq 0 ]; then  
            echo "$(date): Cron tasks file permissions have been set to 777 (WARNING: This is insecure!)" >> "$LOG_FILE"  
        else  
            echo "$(date): Failed to set permissions for $CRON_FILE" >> "$LOG_FILE"  
        fi  
    else  
        echo "$(date): Failed to create cron tasks file $CRON_FILE" >> "$LOG_FILE"  
        exit 1  # 退出脚本，因为无法继续  
    fi  
fi  
  
# 如果CRON_FILE存在，则更新crontab  
if [ -f "$CRON_FILE" ]; then  
    # crontab  
    crontab -u $USER "$CRON_FILE"  
  
    # 检查是否成功更新了crontab  
    if [ $? -eq 0 ]; then  
        echo "$(date): Cron tasks for $USER have been updated from $CRON_FILE" >> "$LOG_FILE"  
  
        # 注意：通常不需要直接修改CRONTAB_FILE的权限，因为它是系统管理的  
        # 但如果您确实需要这样做（不推荐），请确保您知道为什么  
        # chmod 777 "$CRONTAB_FILE"  # 这行通常是不需要的，并且可能会导致问题  
        # if [ $? -eq 0 ]; then  
        #     echo "$(date): Crontab file permissions have been changed to 777 (WARNING: This is insecure!)" >> "$LOG_FILE"  
        # else  
        #     echo "$(date): Failed to change crontab file permissions" >> "$LOG_FILE"  
        # fi  
    else  
        #  
        echo "$(date): Failed to update cron tasks for $USER from $CRON_FILE" >> "$LOG_FILE"  
    fi  
else  
    # 如果CRON_FILE在之前没有被创建（或仍然存在其他问题）  
    echo "$(date): Cron tasks file $CRON_FILE does not exist!" >> "$LOG_FILE"  
fi  
  
#  
echo "$(date): set_crontab.sh ok" >> "$LOG_FILE"
