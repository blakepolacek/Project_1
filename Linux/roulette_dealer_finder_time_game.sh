#!/bin/bash

if [ $1 -eq 1 ]
then

	grep "$2 $3" *$4* | awk '{print $3, $4}'

elif [ $1 -eq 2 ]
then

	grep "$2 $3" *$4* | awk '{print $5, $6}'

elif [ $1 -eq 3 ]
then

	grep "$2 $3" *$4* | awk '{print $7, $8}'
fi
