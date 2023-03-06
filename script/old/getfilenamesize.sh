#########################################################################
# File Name: getfilenamesize.sh
# Author: sufg
# mail: sufg_2991@163.com
# Created Time: 2023年02月28日 星期二 11时15分40秒
#########################################################################
#!/bin/bash

function ergodic(){

	for file in `ls $1`
	do
		if [ -d $1"/"$file ]
		then
			ergodic $1"/"$file
		else
			local path=$1"/"$file
			local name=$file
			local size=`du --max-depth=1 $path|awk '{
			print $1}'`
			echo $name  $size $path
		fi
	done
}

IFS=$'\n' #这个必须要，否则会在文件名中有空格时出错
INIT_PATH=".";

ergodic $INIT_PATH:

