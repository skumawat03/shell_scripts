#!/bin/bash

if [ -e stat_log.log ]
then
	truncate -s 0 stat_log.log
else
	touch stat_log.log
fi

cpu="top -b -n 1 | grep Cpu | cut -d, -f4 | awk '{print $2 + $4}'"

mem="free -t -m | grep Total | awk '{print $4}'"

home="df -h | grep home | awk '{print $5}' | cut -d % -f 1"

for i in `cat serverlist.txt`
do
	cpu_stat=`ssh $i $cpu`
	mem_stat=`ssh $i $mem`
	home_stat=`ssh $i $home`
	echo "Server $i" >>stat_log.log
	echo "---CPU STATUS---" >>stat_log.log
	echo >>stat_log.log
	echo "Used CPU: $cpu_stat %" >>stat_log.log

	echo "---Memory Status---" >>stat_log.log
	echo >>stat_log.log
	echo "Available memory= $mem_stat MiB" >>stat_log.log

	echo "---/home Status---" >>stat_log.log
	echo >>stat_log.log
	echo "Used= $home_stat %" >>stat_log.log

done
