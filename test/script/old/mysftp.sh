#======================================================
#功能：sftp 下载文件到本地
#调用方法： sh mysftp.sh
#======================================================

#!/bin/bash


#获取系统时间
#time=$1
systime=$(date "+%Y%m%d")

homepath=/home/sufg/proc/test/
logpath=${homepath}/log/sftplog/${systime}/
logname=${logpath}/sftpget${systime}.log

#SFTP配置信息
#IP
IP=192.168.40.128
#端口
PORT=22
#用户名
USER=sufg
#密码
PASSWORD='qwe   '
#待接收下载文件根目录
CLIENTDIR=${homepath}/data/p5dir/${systime}/
#服务器待下载目录
SEVERDIR=${homepath}/data/testdir


#判断sftplog路径是否存在不存在则创建
if [ ! -d ${logpath} ]; then
	mkdir -p ${logpath}
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
	echo "[sftpget.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg ">> ${logpath}/sftpget${systime}.log
	echo "[sftpget.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg "
}

#判断文件接收目录是否存在，不存在则创建目录
if [ ! -d ${CLIENTDIR} ]; then
	mkdir -p ${CLIENTDIR}
fi




#文件下载
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



shlog $LINENO "*****************************${systime}数据文件下载开始****************************************"
#同步数据
download ${SEVERDIR} ${CLIENTDIR}
shlog $LINENO "*****************************${systime}数据文件下载结束****************************************"    

exit 0

