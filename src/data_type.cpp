/*************************************************************************
  > File Name: data_type.cpp
  > Author: sufg
  > Mail: sufg_2991@163.com 
  > Created Time: 2022年12月17日 星期六 09时18分10秒
 ************************************************************************/

#include<iostream>
#include<limits>

using namespace std;

typedef int int_4;

void data_type()
{
	
	cout << "type: \t\t" << "************size**************\n\n"<< endl;

	cout << "bool: \t\t" << "所占字节数：" << sizeof(bool);  
	cout << "\t最大值：" << (numeric_limits<bool>::max)();  
	cout << "\t\t最小值：" << (numeric_limits<bool>::min)() << endl;

	cout << "char: \t\t" << "所占字节数：" << sizeof(char);  
	cout << "\t最大值：" << +(numeric_limits<char>::max)();  
	cout << "\t\t最小值：" << +(numeric_limits<char>::min)() << endl;

	cout << "signed char: \t" << "所占字节数：" << sizeof(signed char);  
	cout << "\t最大值：" << +(numeric_limits<signed char>::max)();  
	cout << "\t\t最小值：" << +(numeric_limits<signed char>::min)() << endl;

	cout << "unsigned char: \t" << "所占字节数：" << sizeof(unsigned char);  
	cout << "\t最大值：" << (numeric_limits<unsigned char>::max)();  
	cout << "\t\t最小值：" << (numeric_limits<unsigned char>::min)() << endl;

	cout << "wchar_t: \t" << "所占字节数：" << sizeof(wchar_t);  
	cout << "\t最大值：" << +(numeric_limits<wchar_t>::max)();  
	cout << "\t\t最小值：" << +(numeric_limits<wchar_t>::min)() << endl;

	cout << "short: \t\t" << "所占字节数：" << sizeof(short);  
	cout << "\t最大值：" << (numeric_limits<short>::max)();  
	cout << "\t\t最小值：" << (numeric_limits<short>::min)() << endl;

	cout << "int: \t\t" << "所占字节数：" << sizeof(int);  
	cout << "\t最大值：" << (numeric_limits<int>::max)();  
	cout << "\t最小值：" << (numeric_limits<int>::min)() << endl;

	cout << "unsigned: \t" << "所占字节数：" << sizeof(unsigned);  
	cout << "\t最大值：" << (numeric_limits<unsigned>::max)();  
	cout << "\t最小值：" << (numeric_limits<unsigned>::min)() << endl;

	cout << "long: \t\t" << "所占字节数：" << sizeof(long);  
	cout << "\t最大值：" << (numeric_limits<long>::max)();  
	cout << "\t最小值：" << (numeric_limits<long>::min)() << endl;

	cout << "unsigned long: \t" << "所占字节数：" << sizeof(unsigned long);  
	cout << "\t最大值：" << (numeric_limits<unsigned long>::max)();  
	cout << "\t最小值：" << (numeric_limits<unsigned long>::min)() << endl;

	cout << "double: \t" << "所占字节数：" << sizeof(double);  
	cout << "\t最大值：" << (numeric_limits<double>::max)();  
	cout << "\t最小值：" << (numeric_limits<double>::min)() << endl;

	cout << "long double: \t" << "所占字节数：" << sizeof(long double);  
	cout << "\t最大值：" << (numeric_limits<long double>::max)();  
	cout << "\t最小值：" << (numeric_limits<long double>::min)() << endl; 

	cout << "float: \t\t" << "所占字节数：" << sizeof(float);  
	cout << "\t最大值：" << (numeric_limits<float>::max)();  
	cout << "\t最小值：" << (numeric_limits<float>::min)() << endl;

	cout << "size_t: \t" << "所占字节数：" << sizeof(size_t);  
	cout << "\t最大值：" << (numeric_limits<size_t>::max)();  
	cout << "\t最小值：" << (numeric_limits<size_t>::min)() << endl;

	cout << "string: \t" << "所占字节数：" << sizeof(string) << endl;  
	cout << "\t最大值：" << (numeric_limits<string>::max)() << "\t最小值：" << (numeric_limits<string>::min)() << endl;


	cout << "type: \t\t" << "************size**************\n\n"<< endl;

	//typedef 声明
	int_4 a = 3;
	cout <<"a=["<< a <<"]" <<endl;

	//枚举值 因为默认情况下，每个名称都会比它前面一个名称大 1，但 red 的值依然为 0
	enum color{red,green,blue=7,key}b;
    b = key;	
	cout <<"b=["<< b <<"]"<<endl;
}
