#! /bin/bash
__CONFIGFILE__='base.conf'
sleep 10
ulimit -s 81920
cd /home/face_detect/
function GetKey(){
    section=$(echo $1 | cut -d '.' -f 1)    
    key=$(echo $1 | cut -d '.' -f 2)    
    sed -n "/\[$section\]/,/\[.*\]/{    
      /^\[.*\]/d    
      /^[ \t]*$/d    
      /^$/d    
      /^#.*$/d    
      s/^[ \t]*$key[ \t]*=[ \t]*\(.*\)[ \t]*/\1/p    
    }" $__CONFIGFILE__   
}

while true;do
	ret=$(GetKey "detect_state.detect_state")
    	if [ $ret -eq 0 ];then
		echo "detect_state is 0 , stop detect"
        echo "==============================="
        echo "detect_state is ${ret}"
		ret=$(ps -A -o'pid,stime,etime,cmd' | grep -w mock | grep -v grep | awk '{print $1}')
		if [ "x${ret}" != "x" ];then
			killall -9 mock
		fi
		sleep 5
		continue
	    fi
	ret=$(ps -ef | grep mock | grep -v grep | wc -l)
	if [ $ret -eq 0 ];then
		echo "start fpd"
		echo $PWD
		#(./fpd > ./run.log 2>&1 &)
        (./mock.py > ./run.log 2>&1 &)
		echo "start success"
		sleep 5
	else
		echo "fpd is running"
		sleep 5
	fi
done
