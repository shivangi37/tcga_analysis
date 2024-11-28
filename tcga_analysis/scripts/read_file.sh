#!/bin/bash

while read -r file ; do
	if [ -e $file ] ; then
 		cat "$file"
	fi
done
