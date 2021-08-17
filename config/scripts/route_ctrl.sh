#!/bin/bash

#VyOS route ctrl

ctrltable1=$(/sbin/ip route ls table 1)
ctrltable33=$(/sbin/ip route ls table 33)
ctrltable44=$(/sbin/ip route ls table 44)
ctrltable49=$(/sbin/ip route ls table 49)
ctrltable59=$(/sbin/ip route ls table 59)
ctrltable61=$(/sbin/ip route ls table 61)
ctrltable81=$(/sbin/ip route ls table 81)

[[ $ctrltable1 == "" ]] && \
	PREFIX=1 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 || \
	PREFIX=1 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 
	fi 

[[ $ctrltable33 == "" ]] && \
	PREFIX=33 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 || \
	PREFIX=33 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 
	fi 
	
[[ $ctrltable44 == "" ]] && \
	PREFIX=44 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 || \
	PREFIX=44 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 
	fi 
	
[[ $ctrltable49 == "" ]] && \
	PREFIX=49 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun5 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 || \
	PREFIX=49 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 
	fi 
	

[[ $ctrltable59 == "" ]] && \
	PREFIX=59 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 || \
	PREFIX=59 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 
	fi 

[[ $ctrltable61 == "" ]] && \
	PREFIX=61 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun6 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun5 || \
	PREFIX=61 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun6 
	fi 

[[ $ctrltable81 == "" ]] && \
	PREFIX=81 && \
	/sbin/ip route add table ${PREFIX} default nexthop dev tun2 && \
	/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 && \
	/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 && \
	/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun3 && \
	/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 && \
	/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 && \
	/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 || \
	PREFIX=81 && \
	ctrltun0=$(/sbin/ip route ls table ${PREFIX} | grep tun0) && \
	ctrltun1=$(/sbin/ip route ls table ${PREFIX} | grep tun1) && \
	ctrltun2=$(/sbin/ip route ls table ${PREFIX} | grep tun2) && \
	ctrltun3=$(/sbin/ip route ls table ${PREFIX} | grep tun3) && \
	ctrltun4=$(/sbin/ip route ls table ${PREFIX} | grep tun4) && \
	ctrltun5=$(/sbin/ip route ls table ${PREFIX} | grep tun5) && \
	ctrltun6=$(/sbin/ip route ls table ${PREFIX} | grep tun6) && \
	if [[ $ctrltun0 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 1 default nexthop dev tun0 
	fi && \
	if [[ $ctrltun1 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 2 default nexthop dev tun1 
	fi && \
	if [[ $ctrltun2 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} default nexthop dev tun2 
	fi && \
	if [[ $ctrltun3 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 3 default nexthop dev tun3 
	fi && \
	if [[ $ctrltun4 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 4 default nexthop dev tun4 
	fi && \
	if [[ $ctrltun5 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 5 default nexthop dev tun5 
	fi && \
	if [[ $ctrltun6 == "" ]]; then 
		/sbin/ip route add table ${PREFIX} metric 6 default nexthop dev tun6 
	fi 

	
	
