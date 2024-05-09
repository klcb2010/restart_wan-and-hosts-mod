#!/bin/bash  
# /jffs/scripts/restart_wan.sh  
  
# ������־�ļ�·������ű�ͬĿ¼��  
LOG_FILE="/jffs/scripts/restart_wan.log"  
  
# ��ȡ��ǰ���ڵ��ղ���  
CURRENT_DAY=$(date +"%d")  
  
# ��鵱ǰ�����Ƿ�Ϊż�����ܱ�2������  
if ((CURRENT_DAY % 2 == 0)); then  
    # �����ż�����ڣ���ִ�����²���  
    echo "$(date) - Starting restart_wan.sh on even day" >> "$LOG_FILE"  
  
    # ִ����������������Ҳ��¼����־��  
    /sbin/service restart_wan >> "$LOG_FILE" 2>&1  
  
    # �����һ��������˳�״̬��������־�м�¼  
    if [ $? -eq 0 ]; then  
        echo "$(date) - Service restart_wan restarted successfully on even day" >> "$LOG_FILE"  
    else  
        echo "$(date) - Failed to restart service restart_wan on even day" >> "$LOG_FILE"  
    fi  
  
    # д��ִ�н�������־  
    echo "$(date) - Finished restart_wan.sh on even day" >> "$LOG_FILE"  
else  
    # �������ż�����ڣ����¼��־����ִ������  
    echo "$(date) - Skipping restart_wan.sh on odd day" >> "$LOG_FILE"  
fi