#======================================================
#���ܣ�sftp �����ļ�������
#���÷����� sh mysftp.sh
#======================================================

#!/bin/bash


#��ȡϵͳʱ��
#time=$1
systime=$(date "+%Y%m%d")

homepath=/home/sufg/proc/test/
logpath=${homepath}/log/sftplog/${systime}/
logname=${logpath}/sftpget${systime}.log

#SFTP������Ϣ
#IP
IP=192.168.40.128
#�˿�
PORT=22
#�û���
USER=sufg
#����
PASSWORD='qwe   '
#�����������ļ���Ŀ¼
CLIENTDIR=${homepath}/data/p5dir/${systime}/
#������������Ŀ¼
SEVERDIR=${homepath}/data/testdir


#�ж�sftplog·���Ƿ���ڲ������򴴽�
if [ ! -d ${logpath} ]; then
	mkdir -p ${logpath}
fi

#�жϱ��ؽ����ļ�Ŀ¼�Ƿ���ڲ������򴴽�
if [ ! -d ${CLIENTDIR} ]; then
	mkdir -p ${CLIENTDIR}
fi




#��־���Ŀ¼
shlog()
{
	local line_no msg 
	line_no=$1
	msg=$2
	echo "[sftpget.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg ">> ${logpath}/sftpget${systime}.log
	echo "[sftpget.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg "
}

#�ж��ļ�����Ŀ¼�Ƿ���ڣ��������򴴽�Ŀ¼
if [ ! -d ${CLIENTDIR} ]; then
	mkdir -p ${CLIENTDIR}
fi




#�ļ�����
download()
{

lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd $1
lcd $2
mirror $1 $2
ls -l $1 >> $2/filelist_${systime}.ok
bye
EOF

}



shlog $LINENO "*****************************${systime}�����ļ����ؿ�ʼ****************************************"
#ͬ������
download ${SEVERDIR} ${CLIENTDIR}
shlog $LINENO "*****************************${systime}�����ļ����ؽ���****************************************"    

exit 0

