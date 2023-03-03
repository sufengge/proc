#======================================================
#���ܣ�sftp Զ�������ļ�������
#���÷����� sh sftpget.sh
#======================================================
#!/bin/bash


#��ȡϵͳʱ��
#SYSTIME=$1 ���ڿ����ֶ�����ʱ��
SYSTIME=$(date "+%Y%m%d")
WORKHOME=/home/sufg/proc/test/
LOGPATH=${WORKHOME}/log/sftplog/${SYSTIME}/
LOG=${LOGPATH}/sftpget_${SYSTIME}.log
OKFILE=FileList_${SYSTIME}.OK



#�����������ļ���Ŀ¼
CLIENTDIR=${WORKHOME}/data/p5dir/${SYSTIME}/
#������������Ŀ¼
SEVERDIR=${WORKHOME}/data/testdir/


#�жϱ�����־·���Ƿ���ڲ������򴴽�
if [ ! -d ${LOGPATH} ]; then
	mkdir -p ${LOGPATH}
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
	echo "[sftpget.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg ">> ${LOG}
}





shlog $LINENO "========================START========================"
#��������
sh ${WORKHOME}/script/download.sh ${SEVERDIR} ${CLIENTDIR} ${OKFILE} >> ${LOG} 2>&1
shlog $LINENO "*****************************************************"
sh ${WORKHOME}/script/download2.sh ${SEVERDIR} ${CLIENTDIR} ${OKFILE} >> ${LOG} 2>&1
shlog $LINENO "========================END  ========================"
exit 0






#û���ļ�����ֹ�ű�
