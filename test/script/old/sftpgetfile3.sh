#!/bin/bash
USER=root
#����
PASSWORD=5EYS40T04BMF
#�����ļ�Ŀ¼
SRCDIR=/u02/dab
#FTPĿ¼(�������ļ�Ŀ¼)
DESDIR=/u01/sftpFiles
#����IP
IP=192.168.1.10
#�˿�
PORT=22022

lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT}<<EOF
cd ${DESDIR}
lcd ${SRCDIR}
#��Ҫ���ص��ļ�Ϊtext.xml
get text.xml
by
EOF