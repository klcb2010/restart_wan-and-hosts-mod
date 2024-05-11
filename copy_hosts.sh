#!/bin/bash    
  
# 源文件路径    
source_file="/jffs/scripts/hosts"    
  
# 目标文件路径    
target_file="/tmp/etc/hosts"    
  
# 检查源文件是否存在    
if [ ! -f "$source_file" ]; then    
    echo "Error: Source file $source_file does not exist."    
    exit 1    
fi    
  
# 使用cp命令覆盖目标文件，这里使用-f选项强制覆盖，如果目标文件存在    
cp -f "$source_file" "$target_file"    
  
# 检查操作是否成功    
if [ $? -eq 0 ]; then    
    echo "File $source_file has been copied to $target_file successfully."    
  
    # 现在修改ss_rule_update.sh中的URL_MAIN变量  
    sed -i 's#^URL_MAIN.*#URL_MAIN="https://mirror.ghproxy.com/https%3A%2F%2Fraw.githubusercontent.com%2Fqxzg%2FActions%2F3.0%2Ffancyss_rules"#g' /koolshare/scripts/ss_rule_update.sh  
  
    # 检查sed操作是否成功（这里只是简单地打印消息，因为sed通常没有返回值来指示替换是否发生）  
    echo "URL_MAIN in ss_rule_update.sh has been updated."  
else    
    echo "Error occurred while copying the file."    
    exit 1    
fi  
  
# 脚本的其余部分（如果有的话）  
  
exit 0
