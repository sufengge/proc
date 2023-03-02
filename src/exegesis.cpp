/*************************************************************************
    > File Name: exegesis.cpp
    > Author: sufg
    > Mail: sufg_2991@163.com 
    > Created Time: 2022年12月16日 星期五 22时23分01秒
 ************************************************************************/

#include<iostream>

using namespace std;

#define DBFLAG false


void exegesis() {


	    /* 这是注释 */
	 
	    /* C++ 注释也可以
		 *      * 跨行
		 *           */ 
	    cout << "这是注释!"<<endl;

		// #if 0 ... #endif
		
		/*1.你可以把 #if 0 改成 #if 1 来执行 code 的代码。
		 *
		 * 这种形式对程序调试也可以帮助，测试时使用 #if 1 来执行测试代码，发布后使用 #if 0 来屏蔽测试代码。
		 *
		 * */
		#if DBFLAG
			cout << "调试代码"<<endl;
		#else
			cout << "正常逻辑"<<endl;
		#endif
}
