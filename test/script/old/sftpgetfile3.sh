#!/bin/bash
USER=root
#密码
PASSWORD=5EYS40T04BMF
#下载文件目录
SRCDIR=/u02/dab
#FTP目录(待下载文件目录)
DESDIR=/u01/sftpFiles
#银联IP
IP=192.168.1.10
#端口
PORT=22022

lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT}<<EOF
cd ${DESDIR}
lcd ${SRCDIR}
#需要下载的文件为text.xml
get text.xml
by
EOF