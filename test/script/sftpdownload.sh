#!/bin/bash
#SFTP������Ϣ
#IP
IP=172.20.10.2
#�˿�
PORT=22
#�û���
USER=DESKTOP-LK63M38
#����
PASSWORD='qwe   '
#�����������ļ���Ŀ¼
CLIENTDIR=/home/sufg/proc/test/data/p5dir
#������������Ŀ¼
SEVERDIR='D:\\data\\20230228\\'


lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <EOF
cd ${SEVERDIR}/
lcd ${CLIENTDIR}
get -r ${SEVERDIR}\\.
by
EOF
