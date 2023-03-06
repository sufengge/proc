#!/bin/bash
#SFTP配置信息
#IP
IP=172.20.10.2
#端口
PORT=22
#用户名
USER=DESKTOP-LK63M38
#密码
PASSWORD='qwe   '
#待接收下载文件根目录
CLIENTDIR=/home/sufg/proc/test/data/p5dir
#服务器待下载目录
SEVERDIR='D:\\data\\20230228\\'


lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <EOF
cd ${SEVERDIR}/
lcd ${CLIENTDIR}
get -r ${SEVERDIR}\\.
by
EOF
