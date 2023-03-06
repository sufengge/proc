#======================================================
#功能：sftp 下载文件到本地执行脚本
#调用方法： download.sh RemoteDir LocalDir
#======================================================
#!/bin/bash



#SFTP配置信息
#IP
IP=192.168.40.128
#端口
PORT=22
#用户名
USER=sufg
#密码
PASSWORD='qwe   '



#文件下载
download()
{

lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd $1
lcd $2
mirror $1 $2
ls -l $1 >> $2/$3
bye
EOF

}


download $1 $2 $3

exit 0

