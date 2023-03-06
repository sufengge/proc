//防止头文件重复
#pragma once


//全局变量
#define MAX 1024
#define SUCC 0
#define FAIL -1


//sftp_get.c

//配置链接
struct ConfSFTP{
	char RemoteDir[1024];
	char IP[50];
	int  Port;
	char UserName[20];
	char Password[1024];
};


//定义T_SFTP_GET 结构体用于更新
struct T_SFTP_GET {

	char TASK_NAME[20];
	char TRAN_STAT[2];
	char SCAN_DATE[21];
};


//定义EXG_FILE_INFO_TBL 结构体用于更新

int sftp_get();
int UpdatTable();
int SplitDate(char *buf,struct ConfSFTP *sftp);




//clear_stat.c
int clear_stat();




//FileChecking.c
int FileChecking(char * patch,char *p8patch);
int ReadFileDir(char * ReadPatch,char *bakdir);
int get_file_size_time(const char *filename,char *bakdir);
int p5dirChecking();
