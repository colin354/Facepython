#! /bin/bash
sleep 10
ulimit -s 81920
cd /home/dr/bin
while true;do
	ret=$(cat start_face)
    	if [ $ret -eq 0 ];then
		echo "Not conf start_face"
		ret=$(ps -A -o'pid,stime,etime,cmd' | grep -w fpd | grep -v grep | awk '{print $1}')
		if [ "x${ret}" != "x" ];then
			killall -9 fpd 
		fi
		sleep 5
		continue
	    fi
	ret=$(ps -ef | grep fpd | grep -v grep | wc -l)
	if [ $ret -eq 0 ];then
		echo "start fpd"
		ip=$(cat ctrl.conf | cut -d'_' -f1)
		port=$(cat ctrl.conf | cut -d'_' -f2)
		if [ "x${ip}" == "x" ];then
			sleep 5
			echo "please check ctrl.conf ip"
			continue
		fi
		if [ "x${port}" == "x" ];then
			sleep 5
			echo "please check ctrl.conf port"
			continue
		fi
		ret=$(cat input.conf | wc -l)
		if [ $ret -eq 0 ];then
			sleep 5
			echo "please check input.conf"
			continue
		fi
		echo "ctrl ip: $ip port $port"
		echo $LD_LIBRARY_PATH
		echo $PWD
		export KMP_BLOCKTIME='0'
		export KMP_NEXT_WAIT='1'
		export OMP_NUM_THREADS='3'
		export KMP_STACKSIZE='16m'
		export OMP_STACKSIZE='16m'
		export GLOG_minloglevel=3
		(./fpd -o /tmp/img -s 0 -i $ip -p $port > ./run.log 2>&1 &)
		echo "start success"
		sleep 5
	else
		echo "fpd is running"
		sleep 5
	fi
done
