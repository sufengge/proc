#======================================================
#���ܣ�sftp �����ļ�������ִ�нű�
#���÷����� download.sh RemoteDir LocalDir
#======================================================
#!/bin/bash



#SFTP������Ϣ
#IP
IP=192.168.40.128
#�˿�
PORT=22
#�û���
USER=sufg
#����
PASSWORD='qwe   '



#�ļ�����
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

