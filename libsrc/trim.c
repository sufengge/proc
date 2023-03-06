/************************************************
C����ȥ���ַ�����β�ո�trim()����ʵ��
//ȥ��β���հ��ַ� ����\t \n \r
��׼�Ŀհ��ַ�������
' '     (0x20)    space (SPC) �ո��
'\t'    (0x09)    horizontal tab (TAB) ˮƽ�Ʊ��    
'\n'    (0x0a)    newline (LF) ���з�
'\v'    (0x0b)    vertical tab (VT) ��ֱ�Ʊ��
'\f'    (0x0c)    feed (FF) ��ҳ��
'\r'    (0x0d)    carriage return (CR) �س���
************************************************/

//ͷ�ļ�
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


//ȥ���ײ��ո�
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

//ȥ����β�ո�
char *trim(char *str)
{
    str = rtrim(str);
    str = ltrim(str);

    return str;
}

