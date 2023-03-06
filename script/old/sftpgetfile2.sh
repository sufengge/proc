#!/bin/bash
#=====================================================
#���ߣ�jasenhua
#���ڣ�2019-05-29
#���ܣ������ļ��ű�
#���÷����� sh download_file.sh YYYYMMDD  source_system   ok_file   txt_file
#=====================================================

edw_etlpath=/data/script/edw/etlpath/data/lh
shell_path=${edw_etlpath}
log_path=${edw_etlpath}/log/download/
etldate=$1
source_system=$2
ok_file=$3
txt_file=$4

#SFTP������Ϣ
#IP
IP=10.11.0.143
#�˿�
PORT=22
#�û���
USER=edw_user
#����
PASSWORD=edw_user123
#�����������ļ���Ŀ¼
CLIENTDIR=${edw_etlpath}/${source_system}/${etldate}
#������������Ŀ¼
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

shlog $LINENO "********�������������ļ���Ŀ¼�Ƿ����,�������򴴽���Ŀ¼****************************************"
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
  shlog $LINENO "�������ļ���СΪ$FTPSIZE"
  shlog $LINENO "�����ļ���СΪ$LOCALSIZE"
  if [ "$FTPSIZE" != "" ] && [ "$FTPSIZE" == "$LOCALSIZE" ]; then
    shlog $LINENO "������$2/$3�ļ����ص�����$1�ɹ�"
else
    shlog $LINENO "������$2/$3�ļ����ص�����$1ʧ��"
    rm -rf $1/tmp.txt
    exit 1
fi
rm -rf $1/tmp.txt
}

shlog $LINENO "*****************************${etldate}�����ļ����ؿ�ʼ****************************************"
#��������OK��־�ļ�
download ${CLIENTDIR} ${SEVERDIR} ${ok_file}

#����TXT�����ļ�
download ${CLIENTDIR} ${SEVERDIR} ${txt_file}

shlog $LINENO "*****************************${etldate}�����ļ����ؽ���****************************************"    

exit 0


