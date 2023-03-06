/*************************************************************************
    > File Name: FileChecking.c
    > Author: sufg
    > Mail: sufg_2991@163.com 
    > Created Time: 2023年02月24日 星期五 10时49分08秒
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
#include "trim.h"


//银联文件大小校验
int p5dirChecking()
{
	return SUCC;
}


int FileChecking(char * p5patch,char *p8patch)
{

	//声明变量
	int Ret = 0;

	/**1.遍历来P8接收文件夹**/	
	printf("开始检查p5下的文件[%s] \n",p5patch);


	//遍历文件目录获取 文件名 文件大小
	Ret = ReadFileDir(p5patch,p8patch);
	if (Ret != 0)
	{

		printf("件传输成功,遍历文件目录更新数据库失败 \n");
		return FAIL; 
	}

	return SUCC;
}



//遍历文件目录更新数据库
int ReadFileDir(char * ReadPatch,char *bakdir)
{


	//声明变量
	DIR *dirp;
	struct dirent *direntp;

	/*打开目录*/
	if((dirp=opendir(ReadPatch))==NULL)
	{

		printf("Open Directory %s Error: %s \n",ReadPatch, strerror(errno));
		return FAIL;
	}


	/*返回目录中文件大小和修改时间*/
	while((direntp=readdir(dirp))!=NULL)
	{


		/*给文件或目录名添加路径：ReadPatch+"/"+direntp->d_name */
		char dirbuf[MAX];
		memset(dirbuf,0x00,sizeof(dirbuf));
		strcpy(dirbuf,ReadPatch);
		trim(dirbuf);
		strcat(dirbuf,"/");
		trim(dirbuf);
		strcat(dirbuf,direntp->d_name);
		trim(dirbuf);

		if(get_file_size_time(dirbuf,bakdir) == -1)
			break;
	}

	closedir(dirp);

	return 0;
}


/*文件大小和修改时间*/
int get_file_size_time(const char *filename,char *bakdir)
{


	struct stat statbuf;
	/*判断未打开文件*/
	if(stat(filename, &statbuf)==-1)
	{

		printf("Get stat on %s Error:%s\n",filename,strerror(errno));
		return(-1);
	}
	if(S_ISDIR(statbuf.st_mode))
		return(1);
	if(S_ISREG(statbuf.st_mode))
	{

		printf("filename[%s] size: [%ld]bytes \t   bakdir[%s]\n", filename, statbuf.st_size,bakdir);
	}

	return(0);
}


