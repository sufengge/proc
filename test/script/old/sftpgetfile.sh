#!/bin/bash
# get all filename in specified path
#源路径
path="/home/file/source/initfile/"
#下载路径
dwpath="/home/bak/File/"
#日志路径
logpath="/home/bak/"
TIME=date +%Y%m%d%H%M%S
rslog=down_$ {TIME}. log
#使用私钥远程登录 ftpkey是创建的密钥127.0.0.2这里代表远程IP
sftp -oIdentityFile=~/.ssh/ftpkey ftpuser@127.0.0.2<<EOF
get ${path} matchname* ${dwpath}
quit
EOF
#定义files文件名需要匹配某字符串
files=$(ls ${dwpath} grep matchname)
rm ${dwpath}*.temp
#没有文件则终止脚本
if [ ! -n "$files" ]
then
echo "no file getted!"
exit 0
else echo "get file successfully!"
fi
#将获取的文件名称输出到txt记录，拼接rm命令，用于后续执行
for filename in $files
do
echo "rm ${path}$filename" >>${logpath}${rslog}
done
#读rslog登录远程端行
rmcmd=$(cat ${logpath}${rslog})
sftp -oIdentityFile=~/.ssh/ftpkey ftpuser@127.0.0.2<<EOF
$rmcmd
quit
EOF
