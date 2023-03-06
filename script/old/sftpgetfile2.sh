#!/bin/bash
#=====================================================
#作者：jasenhua
#日期：2019-05-29
#功能：下载文件脚本
#调用方法： sh download_file.sh YYYYMMDD  source_system   ok_file   txt_file
#=====================================================

edw_etlpath=/data/script/edw/etlpath/data/lh
shell_path=${edw_etlpath}
log_path=${edw_etlpath}/log/download/
etldate=$1
source_system=$2
ok_file=$3
txt_file=$4

#SFTP配置信息
#IP
IP=10.11.0.143
#端口
PORT=22
#用户名
USER=edw_user
#密码
PASSWORD=edw_user123
#待接收下载文件根目录
CLIENTDIR=${edw_etlpath}/${source_system}/${etldate}
#服务器待下载目录
SEVERDIR=${edw_etlpath}/${source_system}/${etldate}

if [ ! -d ${log_path} ]; then
  mkdir -p ${log_path}
fi

shlog()
{
    local line_no msg 
    line_no=$1
    msg=$2
    echo "[download_file.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg ">> ${log_path}/download_file${etldate}.log
    echo "[download_file.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg "
}

shlog $LINENO "********检查待接收下载文件根目录是否存在,不存在则创建该目录****************************************"
if [ ! -d ${CLIENTDIR} ]; then
  mkdir -p ${CLIENTDIR}
fi

download()
{ GF_SRCFILE=$1
  lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
  lcd $1
  get $2/$3
  ls -l $2 >> $1/tmp.txt
bye
EOF

  FTPSIZE=`cat $1/tmp.txt |sed -n '/'$3'/p' |awk '{print $5}'`
  LOCALSIZE=`ls -l $1/$3 |awk '{print $5}'`
  shlog $LINENO "服务器文件大小为$FTPSIZE"
  shlog $LINENO "本地文件大小为$LOCALSIZE"
  if [ "$FTPSIZE" != "" ] && [ "$FTPSIZE" == "$LOCALSIZE" ]; then
    shlog $LINENO "服务器$2/$3文件下载到本地$1成功"
else
    shlog $LINENO "服务器$2/$3文件下载到本地$1失败"
    rm -rf $1/tmp.txt
    exit 1
fi
rm -rf $1/tmp.txt
}

shlog $LINENO "*****************************${etldate}数据文件下载开始****************************************"
#首先下载OK标志文件
download ${CLIENTDIR} ${SEVERDIR} ${ok_file}

#下载TXT数据文件
download ${CLIENTDIR} ${SEVERDIR} ${txt_file}

shlog $LINENO "*****************************${etldate}数据文件下载结束****************************************"    

exit 0


