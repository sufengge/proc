#!/bin/bash


#sftp配置
IP=192.168.40.128
PORT=22
USER=sufg
PASSWORD='qwe   '
FTPKEY=''
CMD="ls -l $1 >> $2/$3"

#使用私钥远程登录 ftpkey是创建的密钥127.0.0.2这里代表远程IP
sftp -oIdentityFile=~/.ssh/ftpkey ${USER}@${IP}<<EOF
get $1 matchname* $2
quit
EOF



#判断下载的文件夹文件是否存在
#定义files文件名需要匹配某字符串
files=$(ls $2 grep matchname)
if [ ! -n "$files" ]
then
echo "no file getted!"
exit 0
else echo "get file successfully!"
fi


#登录远程端目录文件生成ok文件
sftp -oIdentityFile=~/.ssh/ftpkey ${USER}@${IP}<<EOF
${CMD}
quit
EOF
