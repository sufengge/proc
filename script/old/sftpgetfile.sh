#!/bin/bash
# get all filename in specified path
#Դ·��
path="/home/file/source/initfile/"
#����·��
dwpath="/home/bak/File/"
#��־·��
logpath="/home/bak/"
TIME=date +%Y%m%d%H%M%S
rslog=down_$ {TIME}. log
#ʹ��˽ԿԶ�̵�¼ ftpkey�Ǵ�������Կ127.0.0.2�������Զ��IP
sftp -oIdentityFile=~/.ssh/ftpkey ftpuser@127.0.0.2<<EOF
get ${path} matchname* ${dwpath}
quit
EOF
#����files�ļ�����Ҫƥ��ĳ�ַ���
files=$(ls ${dwpath} grep matchname)
rm ${dwpath}*.temp
#û���ļ�����ֹ�ű�
if [ ! -n "$files" ]
then
echo "no file getted!"
exit 0
else echo "get file successfully!"
fi
#����ȡ���ļ����������txt��¼��ƴ��rm������ں���ִ��
for filename in $files
do
echo "rm ${path}$filename" >>${logpath}${rslog}
done
#��rslog��¼Զ�̶���
rmcmd=$(cat ${logpath}${rslog})
sftp -oIdentityFile=~/.ssh/ftpkey ftpuser@127.0.0.2<<EOF
$rmcmd
quit
EOF
