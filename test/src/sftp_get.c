/*************************************************************************
  > File Name: sftp_get.c
  > Author: sufg
  > Mail: sufg_2991@163.com 
  > Created Time: 2023年02月20日 星期一 13时35分50秒
 ************************************************************************/


#include<unistd.h>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<errno.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<dirent.h>
#include "test.h"


int sftp_get()
{

	printf("sftp_get start! \n");
	//定义变量
	int Ret;
	int LinkFlag;
	char buf[2048];
	char cmdbuf[4048];
	char systime[100];
	char CupSftpParmPath[MAX];
	char P5DataPatch[MAX];
	char P8DataPatch[MAX];
	char RemoteDir[MAX];

	struct ConfSFTP sftp;


	//初始化变量
	Ret = SUCC;
	LinkFlag = FAIL;
	memset(&sftp,0x00,sizeof(sftp));
	memset(CupSftpParmPath,0x00,sizeof(CupSftpParmPath));
	memset(buf,0x00,sizeof(buf));
	memset(cmdbuf,0x00,sizeof(cmdbuf));
	memset(systime,0x00,sizeof(systime));
	memset(P5DataPatch,0x00,sizeof(P5DataPatch));
	memset(P8DataPatch,0x00,sizeof(P8DataPatch));
	memset(RemoteDir,0x00,sizeof(RemoteDir));
	memset(&sftp,0x00,sizeof(sftp));



	//获取本地时间
	time_t timep;
	struct tm *p;
	time(&timep);

	p = localtime(&timep);
	sprintf(systime,"%d%02d%02d",(1900+p->tm_year), (1+p->tm_mon), p->tm_mday);
	printf("当前系统时间:%s \n",systime);


	//配置文件路径
    strcpy(CupSftpParmPath,"/home/sufg/proc/test/etc/");						//cupspl-sftp-parm.txt的路径
	strcpy(P5DataPatch,"/home/sufg/proc/test/data/p5dir/");					    //P5存放文件路径
	sprintf(P8DataPatch,"/home/sufg/proc/test/data/p8bak/%s/",systime);		    //P8文件备份路径
	
	//trim 必须去掉前后空格不然太占系统资源
	trim(CupSftpParmPath);
	trim(P5DataPatch);
	trim(P8DataPatch);

	
	
	//判断文件路径是否存在,不存在则创建PATCH
	if(NULL==opendir(CupSftpParmPath))
	{
		mkdir(CupSftpParmPath,0777);	
	}

	if(NULL==opendir(P5DataPatch))
	{
		mkdir(P5DataPatch,0777);	
	}

	printf("P8DataPatch = [%s]\n",P8DataPatch);
	if(NULL==opendir(P8DataPatch))
	{
		mkdir(P8DataPatch,0777);	
	}


	//加配置文件
	strcat(CupSftpParmPath,"cupspl-sftp-parm.txt");



	/*
	 * 先判断表T_SFTP_GET表的TRAN_STAT是否等于00，
	 * 如果是，就更新T_SFTP_GET表的TRAN_STAT为01，同时更新一下时间，加上where TRAN_STAT=’00’的条件（更新失败，成功返回，不往下处理；更新成功，往下继续）；
	 * 如果不是，就成功返回
	 */
	UpdatTable();



	//下载文件到本地
	/*读取枚举文件cupspl-sftp-parm.txt中配置的代理信息和机构连接信息*/
	//打开cupspl-sftp-parm.txt文件
	
	FILE *fp;
	printf("打开[%s] \n",CupSftpParmPath);
	fp = fopen(CupSftpParmPath,"r");
	if (fp == NULL)
	{
		//打开~/etc/cupspl-sftp-parm.txt错误!
		printf("打开cupspl-sftp-parm.txt Error！\n");
		fclose(fp);
		return FAIL;
	}


	//一行一行读取文件
	char * read = NULL;
	while(1)
	{
		//清空结构体
		memset(&sftp,0x00,sizeof(sftp));

		read = fgets(buf,MAX,fp);
		if(read == NULL)
		{
			printf("文件读取完毕！ \n");
			break;
		}

		trim(buf);

		printf("buf[%s]\n",buf);

		//拆分buf，获取到IP、Port、UserName
		Ret = SplitDate(buf,&sftp);
		if(Ret != 0)
		{
			printf("拆分buf，获取到IP、Port、UserName ERRPOR！\n");
			break;
		}

		//将P5环境数据提取到P8环境缓存路径下
		memset(cmdbuf,0x00,sizeof(cmdbuf));
		
		//这里要和银联那边商议用的公钥还是私钥,配置完成可免密传输 从P5环境拿也是要配置密钥 P5相当于一个跳板.
		//sprintf(cmdbuf,"scp -r -p %d %s@%s:/%s/* %s",sftp.Port,sftp.UserName,sftp.IP,sftp.RemoteDir,P5DataPatch);
		sprintf(cmdbuf,"cp %s/* %s",sftp.RemoteDir,P5DataPatch);
		trim(cmdbuf);
		printf("cmdbuf= [%s] \n",cmdbuf);
		Ret = system(cmdbuf);
		if(Ret == 0)
		{
			//脚本执行成功
			LinkFlag = 1;
			break;
		}

	}

	//判断sftp是否链接成功
	if(LinkFlag == SUCC)
	{
		//链接不成功
		/*链接不通更新T_SFTP_GET表的TRAN_STAT为00，加上where TRAN_STAT=’01’的条件，同时更新一下时间，随后退出*/
		UpdatTable();

		//关闭文件描述符
		fclose(fp);
		printf("链接不成功！ERROR! \n");
		return SUCC;
	}


	//关闭文件描述符
	fclose(fp);

	/*文件大小校验*/
	//主要查看P5下的清单是否下载成功到P8的文件大小相同
	

	/* 文件成功落地，进行文件校验和入库操作  */


	//P5下文件大小校验留个接口,文件大小不完整,备份到errbak目录下去
	p5dirChecking();

	/*
	 * p5目录下的文件大小没问题
	 * P5目录下文校验接受的文件数据库是否已经注册，
	 * 未注册接着往下走，文件已经注册判断文件大小，
	 * 若数据库中注册的文件小于接收路径下的文件则更新数据库
	*/
	Ret = FileChecking(P5DataPatch,P8DataPatch);
	if(Ret)
	{
		//文件校验失败
		printf("文件校验失败 ！\n");
		return FAIL;
	}

	
	return SUCC;
}


/*更新数据库操作*/
int UpdatTable()
{

	//变量声明
	char sql[MAX];
	//初始化变量
	memset(sql,0x00,sizeof(sql));
	return SUCC;
}



int SplitDate(char *buf,struct ConfSFTP *sftp)
{
	//变量声明
	int i = 0;
	char *temp = NULL;
	char strbuf[MAX];

	//初始化结构体
	memset(strbuf,0x00,sizeof(strbuf));

	//拆分数据，保存到sftp
	temp = strtok(buf,"|@|");
	while(temp)
	{
		memset(strbuf,0x00,sizeof(strbuf));
		printf("第%d个字符串[%s] \n",i,temp);
		sprintf(strbuf,"%s",temp);
		trim(strbuf);
		
		//UserName
		if(i == 0)
		{
			strcpy(sftp->UserName,strbuf);
		}
		//Port
		if(i == 1)
		{
			sftp->Port = atoi(strbuf);
		}
		//IP
		if(i == 2)
		{
			strcpy(sftp->IP,strbuf);
		}
		//远程目录
		if(i == 3)
		{
			strcpy(sftp->RemoteDir,strbuf);
		}


		i ++;
		temp = strtok(NULL,"|@|");
	}

	return SUCC;
}


