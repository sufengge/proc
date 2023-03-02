/*************************************************************************
    > File Name: main.c
    > Author: sufg
    > Mail: sufg_2991@163.com 
    > Created Time: 2023年02月23日 星期四 15时13分36秒
 ************************************************************************/
#include<stdio.h>
#include<string.h>
#include"test.h"


int main()
{

	printf("入口函数\n");
	   
	//下载文件
	sftp_get();

	//更新数据库
    clear_stat();


	printf("程序结束!\n");
		    
	return SUCC;
}

