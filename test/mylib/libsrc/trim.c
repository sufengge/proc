/************************************************
C语言去除字符串首尾空格，trim()函数实现
//去除尾部空白字符 包括\t \n \r
标准的空白字符包括：
' '     (0x20)    space (SPC) 空格符
'\t'    (0x09)    horizontal tab (TAB) 水平制表符    
'\n'    (0x0a)    newline (LF) 换行符
'\v'    (0x0b)    vertical tab (VT) 垂直制表符
'\f'    (0x0c)    feed (FF) 换页符
'\r'    (0x0d)    carriage return (CR) 回车符
************************************************/

//头文件
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "test.h"


char *rtrim(char *str)
{
    if (str == NULL || *str == '\0')
    {
        return str;
    }

    int len = strlen(str);
    char *p = str + len - 1;
    while (p >= str  && isspace(*p))
    {
        *p = '\0';
        --p;
    }

    return str;
}


//去除首部空格
char *ltrim(char *str)
{
    if (str == NULL || *str == '\0')
    {
        return str;
    }

    int len = 0;
    char *p = str;
    while (*p != '\0' && isspace(*p))
    {
        ++p;
        ++len;
    }

    memmove(str, p, strlen(str) - len + 1);

    return str;
}

//去除首尾空格
char *trim(char *str)
{
    str = rtrim(str);
    str = ltrim(str);

    return str;
}

