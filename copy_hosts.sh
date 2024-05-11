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
else  
    echo "Error occurred while copying the file."  
    exit 1  
fi
