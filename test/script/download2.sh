#!/bin/bash


#sftp����
IP=192.168.40.128
PORT=22
USER=sufg
PASSWORD='qwe   '
FTPKEY=''
CMD="ls -l $1 >> $2/$3"

#ʹ��˽ԿԶ�̵�¼ ftpkey�Ǵ�������Կ127.0.0.2�������Զ��IP
sftp -oIdentityFile=~/.ssh/ftpkey ${USER}@${IP}<<EOF
get $1 matchname* $2
quit
EOF



#�ж����ص��ļ����ļ��Ƿ����
#����files�ļ�����Ҫƥ��ĳ�ַ���
files=$(ls $2 grep matchname)
if [ ! -n "$files" ]
then
echo "no file getted!"
exit 0
else echo "get file successfully!"
fi


#��¼Զ�̶�Ŀ¼�ļ�����ok�ļ�
sftp -oIdentityFile=~/.ssh/ftpkey ${USER}@${IP}<<EOF
${CMD}
quit
EOF
