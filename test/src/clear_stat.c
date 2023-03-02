/*************************************************************************
    > File Name: clear_stat.c
    > Author: sufg
    > Mail: sufg_2991@163.com 
    > Created Time: 2023年02月20日 星期一 13时36分37秒
 ************************************************************************/

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include "test.h"

/*
 *判断表T_SFTP_GET表的TRAN_STAT是否等于01，并且时间距当前时间是否超过2小时，如果是，则更新T_SFTP_GET表的TRAN_STAT为00，加上where TRAN_STAT=’01’的条件；如果否，则成功退出
 * */
int clear_stat()
{
	//更新数据库已经过去一小时的数据
	//UPDATE T_SFTP_GET SET TRAN_STAT = '00',SCAN_DATE = GETDATE() WHERE TRAN_STAT= '01' AND SCAN_DATE > DATEADD(hour, -2 , GETDATE()) 

	return 0;
}



