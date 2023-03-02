/*************************************************************************
    > File Name: constant.cpp
    > Author: sufg
    > Mail: sufg_2991@163.com 
    > Created Time: 2023年01月05日 星期四 13时51分26秒
 ************************************************************************/

#include<iostream>
#include<unistd.h>
#include<string.h>
#include"variable.h"

using namespace std;

void constant(){

	int i = 0;
	int MAX = 3;

	//常量
	//字符串常量
	string a = "我爱你媳妇！";
	cout << a <<endl;


	for(i = 0 ; i < MAX; i++)
	{
		sleep(1); 
		cout << "开始发出第 ["<<i<<"]响声！\a"<<endl;

	}

	
}
