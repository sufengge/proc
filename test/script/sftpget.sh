#======================================================
#功能：sftp 远程下载文件到本地
#调用方法： sh sftpget.sh
#======================================================
#!/bin/bash


#获取系统时间
#SYSTIME=$1 后期可以手动输入时间
SYSTIME=$(date "+%Y%m%d")
WORKHOME=/home/sufg/proc/test/
LOGPATH=${WORKHOME}/log/sftplog/${SYSTIME}/
LOG=${LOGPATH}/sftpget_${SYSTIME}.log
OKFILE=FileList_${SYSTIME}.OK



#待接收下载文件根目录
CLIENTDIR=${WORKHOME}/data/p5dir/${SYSTIME}/
#服务器待下载目录
SEVERDIR=${WORKHOME}/data/testdir/


#判断本地日志路径是否存在不存在则创建
if [ ! -d ${LOGPATH} ]; then
	mkdir -p ${LOGPATH}
fi

#判断本地接收文件目录是否存在不存在则创建
if [ ! -d ${CLIENTDIR} ]; then
	mkdir -p ${CLIENTDIR}
fi




#日志输出目录
shlog()
{
	local line_no msg 
	line_no=$1
	msg=$2
	echo "[sftpget.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg ">> ${LOG}
}





shlog $LINENO "========================START========================"
#下载数据
sh ${WORKHOME}/script/download.sh ${SEVERDIR} ${CLIENTDIR} ${OKFILE} >> ${LOG} 2>&1
shlog $LINENO "*****************************************************"
sh ${WORKHOME}/script/download2.sh ${SEVERDIR} ${CLIENTDIR} ${OKFILE} >> ${LOG} 2>&1
shlog $LINENO "========================END  ========================"
exit 0






#没有文件则终止脚本
