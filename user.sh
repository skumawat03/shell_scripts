#!/bin/bash

while getopts u:d: arg
do
	case $arg in
		u) id=$OPTARG
			;;
		d) home=$OPTARG
			;;
	esac
done
shift $((OPTIND-1))
echo "useradd -d $home $id"
