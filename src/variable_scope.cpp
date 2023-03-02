/*************************************************************************
    > File Name: variable_scope.cpp
    > Author: sufg
    > Mail: sufg_2991@163.com 
    > Created Time: 2022年12月30日 星期五 18时02分58秒
 ************************************************************************/

#include<iostream>

using namespace std;

//全局变量
int	a = 4;

void variable_scope()
{
	cout <<"variable_scope"<< endl;
	//int a = 3; //局部变量
	
	cout <<"a = ["<< a <<"]"<< endl;
}
