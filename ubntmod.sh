#!/bin/bash

#
# Latest and Greatest UBNTMOD tool
#

#
##
### Ubiquiti AirMax Mod script
##
#

############
# Getopts
##########
while getopts a:Bb:ec:C:D:di:l:IN:n:RK:p:P:r:s:S:t:f:hU:u:Ww:X:Yy:zZv options
do
        case "${options}"
        in
		a) 
		  yacontrol="1"
		  acontrol=${OPTARG}	;;
		B) 
		  backup="1"		;;
		b) 
		  restore="1"
		  yrestore=${OPTARG}	;;
		e) 
		  yconnection="1"	;;
		D) 
		  ydns="1"  # enable/disable dnsproxy
		  dnsproxy=${OPTARG}	;;
		i) 
		  ip=${OPTARG}		;;
		l) 
		  ylog="1"
		  log=${OPTARG}		;;
		I) 
		  info="1"		;;
		N) 
		  name="1"		
		  yname=${OPTARG}	;;
		n) 
		  yntp="1"		
		  ntp=${OPTARG}	;;
		R) 
		  reboot="1"		;;
		d) 
		  discover="1"		;;
		K) 
		  yaddsshkey="1"
		  keypath=${OPTARG}	;;
		p) 
		  ypassword="1"
		  password=${OPTARG}	;;
		P) 
		  ypskchange="1"
		  pskchange=${OPTARG}	;;
		r) 
		  ydelsshkey="1"
		  delTerm=${OPTARG}	;;
		s) 
		   ysnmp="1"
		   snmp=${OPTARG}	;;
		S) 
		   yssid="1"
		   ssid=${OPTARG}	;;
		t) 
		   ytshaper="1"
		   tshaper=${OPTARG}	;;
		c) 
		   comand="1"
		   comandFrom=${OPTARG}	;;
		C) 
		   comandTo=${OPTARG}	;;
		U) 
		   yupgrade="1"
		   firmware=${OPTARG};;
		u) 
		   yusername="1"
		   username=${OPTARG};;
		w) 
		   ychannelwidth="1"
		   channelwidth=${OPTARG};;
		W) 
		   wifiscan="1";;
		X) 
		   xxcommand="1"
		   xcommand=${OPTARG};;
		Y) 
		   ycommand="1";;
		y) 
		   yunpw="1"
		   unpw=${OPTARG};;
	        z)
                   softrestart="1";;
		Z) 
		   saveandreboot="1";;
                f)
                   fison="1"
                   FILE=${OPTARG}	;;
                v) 
		   yversion=1 		;;
                h) 
		   help="1" 		;;
                \?) 
		   help="1" 		;;
        esac
done

# Script Version
version="1.0.6"

# ### Version 1.0.6 Changes (5/24/2019)
# Enabled Remote syslog

tstamp=`date +%M%d%Y-%H%m%S`

# SSH Connection config
# Change username and password for script
# Username and Password
if [[ ${yunpw} = "1" ]] ; then
    	un=`echo ${unpw} | cut -d"," -f1`
	pw=`echo ${unpw} | cut -d"," -f2`
else
    # Run through and see if any of the un or pw's are correct
    un="ubnt"
    pw="ubnt"
    echo "Current User Pass combo is $un $pw"
    ssh="timeout 30 sshpass -p ${pw} ssh -o stricthostkeychecking=no ${un}@${ip}"
    ${ssh} ls
        if [ $? -eq 0 ]; then
            echo "un/pw = ubnt"
        else
            echo "default password failed, trying 2nd pair"
            un="admin"
            pw="password"
            echo "Current User Pass combo is $un $pw"
            ssh="timeout 30 sshpass -p ${pw} ssh -o stricthostkeychecking=no ${un}@${ip}"
            $ssh ls
	    if [ $? -eq 0 ]; then
		    echo "password pair found"
	    else
		    echo "no passwords worked"

	    fi
        fi
fi

#end of passwords

# Remove the previous known hosts ## Need to create a function for it.
# cat /dev/null > ~/.ssh/known_hosts  # Can be used as a work around if there are issues with previously known hosts.

# SSH Commands
SSH="timeout 30 sshpass -p ${pw} ssh -o StrictHostKeyChecking=no ${un}@${ip}" #|| echo \"SSH Failed for some reason, please check settings\""
#SCP="sshpass -p${pw} /usr/bin/scp -oKexAlgorithms=+diffie-hellman-group1-sha1 -o StrictHostKeyChecking=no"
SCP="sshpass -p${pw} /usr/bin/scp  -o StrictHostKeyChecking=no"

# UBNT device config file
config="/tmp/system.cfg"


# Functions for changing stuff 

#function RANDOM {
## How a function should work
#OPTline="option.1.othername=disabled"
#if (echo ${OPTARG} | grep -i 'off\|disable'); then
#	# Check to see if arg needs to change
#	putOPTARG="sed -i s/dhcpd.1.dnsproxy=.*/dhcpd.1.dnsproxy=disabled/g /tmp/system.cfg"
#else
#	echo "Enabling Option"
#	putOPTARG="sed -i s/dhcpd.1.dnsproxy=.*/dhcpd.1.dnsproxy=enabled/g /tmp/system.cfg"
#fi
#if ( ${SSH} 'cat /tmp/system.cfg' | grep -q $OPTline)
#	echo "Option already enabled"
#else
#	${SSH} ${putOPTARG}
#fi
#}

# AirControl enable/disable
function ACONTROL {
if (echo ${acontrol} | grep -i 'off\|disable\|remove'); then
	echo "Removing AirControl Provisioning."
		for i in `${SSH} 'mca-provision-list' | awk '{print $3}'`
		do
			if (echo ${i} | grep -v -i found); then
				echo "Removing provisioning for ${i}"
				aremove="mca-provision-rm ${i}"
				${SSH} '${aremove}'
			fi
		done
elif (echo ${acontrol} | grep -i -q 'add\|provision\|http'); then
	echo -n "Have not tested provisioning, but should be able to with the mca-provision command. \n Usage: /usr/bin/mca-provision <consoleurl> <ssh-public-key> [<id> [<comment>]] \n Should be able to add it to this part of the script."
fi
}

# Enable/Disable syslog
function SYSLOG {
if (echo ${log} | grep -i 'off\|disable'); then
	echo "Disabling System Log"
	putsyslog="sed -i s/syslog.status=.*/syslog.status=disabled/g /tmp/system.cfg"
	putrsyslog="sed -i s/syslog.remote.status=.*/syslog.remote.status=disabled/g /tmp/system.cfg"
	${SSH} ${putrsyslog}
elif (echo ${log} | grep -i '[0-9][0-9].[0-9][0-9]'); then 
	echo "Think we are wanting to setup remote syslog.  Adding address as rsyslog and enabling."
	${SSH} sed -i "/syslog.remote/d" /tmp/system.cfg 
	putsyslog="sed -i s/syslog.status=.*/syslog.status=enabled/g /tmp/system.cfg"
	putrsyslog="echo syslog.remote.status=enabled >> /tmp/system.cfg"
	putrsyslogip="echo syslog.remote.ip=${log} >> /tmp/system.cfg"
	${SSH} ${putrsyslog}
	${SSH} ${putrsyslogip}
else
	echo "Enabling System Log"
	putsyslog="sed -i s/syslog.status=.*/syslog.status=enabled/g /tmp/system.cfg"
fi
	${SSH} ${putsyslog}
}

# Backup radio config
function BACKUP {
	ybackup=`${SSH} mca-status | head -n1 |cut -d, -f1 | cut -d= -f2 | sed s/\ //g`
	backupName="${ybackup}_${tstamp}.cfg"
	echo "backing up configuration file for ${ip} Saving to ${backupName}"
	if (ls | grep ${backupName} ); then
		echo "Backup file with name taken already."
	else
	${SSH} 'cat /tmp/system.cfg' > ${backupName}
	fi
}


# SSH to radio and see if DNS resolves
function CONNECTION {
externalDomain="bing.com"
sping='ping -c1 '
aliveBits="64 bytes from" # If grep matches this string, then DNS resolved

if ( echo $(${SSH} "${sping} ${externalDomain}") | grep -i -q "${aliveBits}" ); then
	echo "${ip} Resolves DNS"
else
	echo "${ip} NOT resolving DNS"
fi
}

# Enable or Disable DNS Proxy
function DNS {
if (echo ${dnsproxy} | grep -i 'off\|disable'); then
	echo "Disabling DNS Proxy"
	if (${SSH} cat /tmp/system.cfg | grep -q 'dhcpd.1.dnsproxy=enabled'); then
	putdnsproxy="sed -i s/dhcpd.1.dnsproxy=.*/dhcpd.1.dnsproxy=disabled/g /tmp/system.cfg"
	fi
elif (echo ${dnsproxy} | grep -i -q 'status\|?\| \|about'); then
	# echo "Printing DNS Proxy Status"
	putdnsproxy="grep -i dnsproxy= /tmp/system.cfg"
	if (${SSH} ${putdnsproxy} | grep enabled); then
		echo "DNS Proxy is enabled"
	else
		echo "DNS  Proxy looks like it is disabled"
	fi
else
	echo "Enabling DNS Proxy"
	if (${SSH} cat /tmp/system.cfg | grep -q 'dhcpd.1.dnsproxy=disabled'); then
	putdnsproxy="sed -i s/dhcpd.1.dnsproxy=.*/dhcpd.1.dnsproxy=enabled/g /tmp/system.cfg"
	fi
fi
	${SSH} ${putdnsproxy}
}

# Restore a config to a radio
function RESTORE {
	if (ls | grep ${yrestore} ); then
		echo Starting restore process
		${SCP} ${yrestore} ${un}@${ip}:/tmp/system.cfg
		SAVEREBOOT 
	fi
}

# Change Device Name
function NAME {
	echo "Updating device name to ${yname}"
	putname="sed -i s/resolv.host.1.name=.*/'resolv.host.1.name=${yname}'/g /tmp/system.cfg" 

	putname="sed -i s/resolv.host.1.name=.*/'resolv.host.1.name=${yname}'/g /tmp/system.cfg" 
	${SSH} ${putname}
}

# Enable/Disable NTP
function NTP {
	if ( echo ${ntp} | grep 'disable\|disallow\|off' ); then
		echo "Disabling NTP"
		setntp="sed -i s/ntpclient.status=.*/ntpclient.status=disabled/g /tmp/system.cfg" 
	elif ( echo ${ntp} | grep 'enable\|allow' ); then
		if ( ${SSH} grep -i ntp /tmp/system.cfg); then 
			setntp="sed -i s/ntpclient.status=.*/ntpclient.status=enabled/g /tmp/system.cfg" 
		else
			echo "NTP has never been enabled"
			echo "Enabling..."
			${SSH} echo
			setntp="echo -e 'ntpclient.1.status=enabled\nntpclient.1.server=0.ubnt.pool.ntp.org\nntpclient.status=enabled' >> /tmp/system.cfg" 
		fi			
	else
		echo "No Option specified, printing settings" 
		setntp="grep -i ntp /tmp/system.cfg" 
	fi
		${SSH} ${setntp}
}

# Return basic info from device, name firmware, channel, etc...
function INFO {
${SSH} 'mca-status' || echo "SSH Failed for some reason, please check settings"
}

# Reboot radio
function REBOOT {
echo "Rebooting device" 
${SSH} 'reboot'
}

# Run discovery on radio
function DISCOVER {
${SSH} 'discover'
}

# Delete SSH Key from radio - Function 1-2
function DELSSHKEYTERM {
${SSH} sed -i "/${delItem}/d" /tmp/system.cfg
}

# Delete SSH Key from radio - Function 2-2
function DELSSHKEY {
	if ( echo ${delTerm} | grep -i 'sshkey\|sshkeys\|all\|allkeys\|allsshkeys' ); then
		delItem="sshd.auth.key"
		echo "Deleting all ssh keys"
		DELSSHKEYTERM
	elif ( echo ${delTerm} | grep -i 'sshkey1\|sshkeyone\|key1\|one\|1\|first' ); then
		echo "Deleting Key 1"
		delItem="sshd.auth.key.1"
		DELSSHKEYTERM
	elif ( echo ${delTerm} | grep -i 'sshkey2\|sshkeytwo\|key2\|two\|2\|second' ); then
		echo "Deleting Key 2"
		delItem="sshd.auth.key.2"
		DELSSHKEYTERM
	else
		echo "Sorry couldn't parse that up. :/"
		echo "Exiting..."
	fi
}

# Add SSH Key to radio
function ADDSSHKEY {
keyslot="1"
infoOption="SSH"
ssh="${SSH} grep ssh ${config}"
if (echo ${keypath} | grep -i 'info\|status'); then 
	echo "Printing ssh keys"
	${ssh}
	return
fi
if ( echo $keypath | grep -i pub ); then
	echo "No Mods requested, Going to see about adding a Key"
if ( ${ssh} | grep -q "sshd.auth.key.1.status=enabled"    ) ; then  
	echo "ssh key number 1 is used." 
	keyslot="2"
fi
if (  ${ssh} | grep -q "sshd.auth.key.2.status=enabled"  ) ; then  
	echo "ssh key number 2 is used." 
	keyslot="3"
fi

if ( ${ssh} | grep -q $(awk '{print $2}' ${keypath}) ) ; then  
	echo "Key already here.  Not Adding..."
else
	echo "Updating Key"
	sshup="echo -e 'sshd.auth.key.${keyslot}.comment=$(awk '{print $3}' ${keypath})\nsshd.auth.key.${keyslot}.status=enabled\nsshd.auth.key.${keyslot}.type=$(awk '{print $1}' ${keypath})\nsshd.auth.key.${keyslot}.value=$(awk '{print $2}' ${keypath})' >> /tmp/system.cfg" 
	${SSH} ${sshup} 
fi
else
	echo "File does not look like a valid ssh key, please retry"
	echo "Want a Coke?"
fi
}

# Change SSID
function SSID {
echo "Updating SSID to ${ssid}"
cssid="sed -i s/wireless.1.ssid=.*/'wireless.1.ssid=${ssid}/g' /tmp/system.cfg" 
cssid2="sed -i s/wpasupplicant.profile.1.network.1.ssid=.*/'wpasupplicant.profile.1.network.1.ssid=${ssid}'/g /tmp/system.cfg" 
${SSH} "${cssid} && ${cssid2}"
}

# Enable/Disable traffic shaper
function TSHAPER {
argvar="${tshaper}"
currentsetting=`${SSH} grep "tshaper.status=.*" ${config} | cut -d= -f2`
linetochange="tshaper.status=.*"
linechangeto="tshaper.status=${argvar}"
	if ( echo ${argvar} | grep -i 'status\|info' ); then
		echo "Current status is" ${currentsetting}
	elif ( echo ${currentsetting} | grep ${argvar} ); then
		echo ${currentsetting}
		echo "tshaper is already set"
		echo "Not changing"
	elif ( echo ${argvar} | grep 'enabled\|disabled' ); then
		echo "Changing tshaper status from ${currentsetting} to ${argvar}"
		argvar="sed -i s/${linetochange}/${linechangeto}/g ${config} "
		${SSH} ${argvar}
	else
		echo "Something went wrong :/"
	fi
}

# Change WiFi Passkey PSK
function PSK {
argvar="${pskchange}"
currentsetting=`${SSH} grep "aaa.1.wpa.psk=" ${config} | cut -d= -f2`
linetochange="aaa.1.wpa.psk=.*"
line2tochange="wpasupplicant.profile.1.network.1.psk=.*"
line3tochange="wpasupplicant.status=.*"
linechangeto="aaa.1.wpa.psk=${argvar}"
line2changeto="wpasupplicant.profile.1.network.1.psk=${argvar}"
if ( echo ${argvar} | grep -i 'status\|info' ); then
	echo "Current Passkey is" ${currentsetting}
elif ( echo ${argvar} | grep "disable" ); then
	echo "Disabling PSK"
	line3changeto="wpasupplicant.status=disabled"
	argvar="sed -i s/${linetochange}/${linechangeto}/g ${config} && sed -i s/${line2tochange}/${line2changeto}/g ${config} && sed -i s/${line3tochange}/${line3changeto}/g ${config}" 
	${SSH} ${argvar}
elif ( echo ${currentsetting} | grep ${argvar} ); then
	echo ${currentsetting}
	echo "Passkey is already set"
	echo "Not changing"
elif ( echo ${argvar} | grep [1234567890] ); then
	line3changeto="wpasupplicant.status=enabled"
	echo "Changing WPA2-PSK passkey from ${currentsetting} to ${argvar}"
	argvar="sed -i s/${linetochange}/${linechangeto}/g ${config} && sed -i s/${line2tochange}/${line2changeto}/g ${config} && sed -i s/${line3tochange}/${line3changeto}/g ${config}" 
	${SSH} ${argvar}
else
	echo "Something went wrong :/"
fi
}

# Enable/Disable and configure SNMP
function SNMP {
snmpInfo="${SSH} grep -i snmp ${config}"
# Parse passed arguments
if ( echo ${snmp} | grep -q -i 'disable' ) ; then 
	echo "Disabling SNMP"
	snmpstatus="disabled"
	snmp1="sed -i "s/snmp.status=.*/snmp.status=${snmpstatus}/g" /tmp/system.cfg"	
	${SSH} ${snmp1}
	return
elif ( echo ${snmp} | grep -q -i 'enable\|on' ) ; then 
	echo "Enabling SNMP"
	snmpstatus="enabled"
	snmp1="sed -i "s/snmp.status=.*/snmp.status=${snmpstatus}/g" /tmp/system.cfg"	
	${SSH} ${snmp1}
	return
elif ( echo ${snmp} | grep -q -i 'status\|info' ) ; then 
	echo "Printing current SNMP settings"	
	${snmpInfo}
	return
elif ( echo ${snmp} | grep -q -i 'help\|-h\|--help' ) ; then 
	echo "Quick help example"
	echo "./ubntmod.sh -i 192.168.1.20 -s community;contact;location"
	echo ""
	echo "Disable"
	echo "./ubntmod.sh -i 192.168.1.20 -s disable"
else
	# Set SNMP Variables
	snmpstatus="enabled"
	snmpcommunity=`echo ${snmp} | cut -d";" -f1`
	snmpcontact=`echo ${snmp} | cut -d";" -f2`
	snmplocation=`echo ${snmp} | cut -d";" -f3`

	# Check snmp settings
	if ( echo ${snmpstatus} ${snmpcommunity} ${snmpcontact} ${snmpcontact} | egrep -q '(enable|[abcdefghijklmnopqrstuvwxyz]|[abcdefghijklmnopqrstuvwxyz]|[abcdefghijklmnopqrstuvwxyz])' ); then 
		echo -e "community ${commun} ; contact ${contact} ; location ${location}"
		snmp1="echo -e 'snmp.status=${snmpstatus}\nsnmp.community=${snmpcommunity}\nsnmp.contact=${snmpcontact}\nsnmp.location=${snmplocation}' >> /tmp/system.cfg" 
		if ( ${snmpInfo} | egrep -q '(${snmpstatus}|${snmpcommunity}|${snmpcontact}|snmplocation})'); then
			echo "SNMP settings are already set.  Returning"
			return
		else
			# Change SNMP settings
			echo "Updating SNMP settings"
			${SSH} sed -i "/snmp/d" /tmp/system.cfg  # Delete all SNMP settings so we can replace them  # Delete all current SNMP settings so we can add ours
			${SSH} ${snmp1}  # Add SNMP settings  
			echo "Finished Updating SNMP settings"
		fi
	else
		echo "Couldn't read the snmp arguments or there was some other erroir :/"
	fi
fi
}

# Custom config changes
function COMAND {
	echo "Custom Comand selected. Changing ${comandFrom} to ${comandTo}"
	Comand="sed -i "s/${comandFrom}/${comandTo}/g" /tmp/system.cfg" 
	${SSH} "${Comand}"
}

# Change username
function USERNAME {
argvar="${username}"
currentsetting=`${SSH} grep "users.1.name=" ${config} | cut -d= -f2`

linetochange="users.1.name=.*"
linechangeto="users.1.name=${argvar}"
	if ( echo ${argvar} | grep -i 'status\|info' ); then
		echo "Current Username is" ${currentsetting}
	elif ( echo ${currentsetting} | grep ${argvar} ); then
		echo ${currentsetting}
		echo "Username is already set"
		echo "Not changing"
	elif ( echo ${argvar} | grep [abcdefghijklmnopqrstuvwxyz] ); then
		echo "Changing Username from ${currentsetting} to ${argvar}"
		argvar="sed -i s/${linetochange}/${linechangeto}/g ${config}"
		${SSH} ${argvar} else
		echo "Something went wrong :/"
	fi


}

# Change Password
function PASSWORD {

# set password
linechangeto="users.1.password=\`cat /etc/passwd | grep Administrator | cut -d":" -f2\`"
echo "Changing password"
argvar="echo -e \"${password}\n${password}\" | passwd "
argvar2='sed -i -r "s@users.1.password=.*@${linechangeto}@g" /tmp/system.cfg'

${SSH} "echo -e \"${password}\n${password}\" | passwd && sed -i -r \"s@users.1.password=.*@${linechangeto}@g\" /tmp/system.cfg"

echo "Changed password"
pw=${password}
SSH="timeout 30 sshpass -p ${pw} ssh -o StrictHostKeyChecking=no ${un}@${ip}"
}

# Upgrade radio firmware
function UPGRADE {
if (echo ${firmware} | grep -i 'status\|ver\|version\|info'); then
	echo "Printing firmware version"
	${SSH} mca-status | head -n1 | cut -d, -f3  # Print firmware version
else
	firmware2="fwupdate.bin"
        echo "Renaming Firmware"
        cp ${firmware} ./${firmware2}
        echo "Starting Upgrade"
	
        # Upload the Firmware
        echo "Uploading Firmware"
        ${SCP} ${firmware2} ${un}@${ip}:/tmp/

        # Update
        echo "Updating..." 
	# ${SSH} 'ubntbox fwupdate.real -m /tmp/fwupdate.bin' 
	${SSH} 'fwupdate -m' 
        echo "Finished at:" `date` 
fi
}

# Change channel width
function CHANNELWIDTH {
argvar="${channelwidth}"
currentsetting=`${SSH} grep "radio.1.chanbw" ${config} | cut -d= -f2`
linetochange="radio.1.chanbw=.*"
linechangeto="radio.1.chanbw=${argvar}"

	if ( echo ${argvar} | grep -i 'status\|info' ); then
		echo "Current Channel Width is"
		argvar=${currentsetting}
		echo ${currentsetting}
	elif ( echo ${currentsetting} | grep -i ${argvar}} ); then
		echo "Radio already on that channel width"
		echo "Not changing"
	elif ( echo ${argvar} | grep '5\|8\|10\|20\|40' ); then
		echo "Changing channel width from ${currentsetting} to ${argvar}"
		argvar="sed -i s/${linetochange}/${linechangeto}/g ${config}" 
		${SSH} ${argvar}
	else
		echo "Something went wrong :/"
	fi
}

# Run Wifi scan on radio
function WIFISCAN {
echo "Starting WIFI Scan from ${ip}"
${SSH} /usr/www/survey.json.cgi
}

# Run custom command
function XCOMMAND {
echo "Running custom command on ${ip}"
${SSH} $xcommand || echo "Command Failed! Permission denied?"
}

# Update Script
function SCRIPTUPGRADE {
updateURL="http://incredigeek.com/home/downloads/ubntmod/"
latestVersion=$(curl -s ${updateURL} | grep ubntmod- | cut -d"\"" -f4 | cut -d- -f2 | sed 's/\.sh//g' | sort -n | tail -n1)

if [[ "${version}" < "${latestVersion}" ]]; then
	echo "There is a new version available.  Updating..."
	wget ${updateURL}ubntmod-${latestVersion}.sh && mv ubntmod-${latestVersion}.sh ubntmod.sh
	chmod +x ubntmod.sh
	echo "Updated!"
else
	echo "No new version available"
fi
}

function SOFTRESTART {
SSH="timeout 30 sshpass -p ${pw} ssh  -o StrictHostKeyChecking=no ${un}@${ip}"
echo "Attempting to execute softrestart"
${SSH} '/usr/etc/rc.d/rc.softrestart save'
}

function SAVEREBOOT {
#SSH="timeout 30 sshpass -p ${pw} ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -o StrictHostKeyChecking=no ${un}@${ip}"
SSH="timeout 30 sshpass -p ${pw} ssh  -o StrictHostKeyChecking=no ${un}@${ip}"
echo "SAVING CHANGES AND REBOOTING..."
${SSH} 'cfgmtd -f /tmp/system.cfg -w && reboot'
}

function VERSION {
echo "UBNTMOD Version ${version}"
}

function HELP {
# Usage:
# ./ubntmod.sh -i 10.10.10.100 -k id_rsa.pub
# usage for Mods:
# ./ubntmod.sh -i 10.10.10.100 -r allkeys
#echo "  ###########################################################################"
echo "//////////////////////\\\\"
echo "\\\ UBNTMOD tool" ${version} " \\\\"
echo " \\\/___/___/___/___/___//"
echo ""
echo "Help and Usage"
echo ""
echo "Usage: ./ubntmod.sh -i TargetIP {OPTIONS}"
echo "Example: Add SSH Key to 192.168.1.20"
echo "./ubntmod.sh -i 192.168.1.20 -K id_rsa.pub -Z"
echo ""
echo "Device to operate against"
echo "-i IPADDRESS,				IP Address of the device."
echo ""
echo "Option usage"	
echo "-a "remove",				Removes AirControl provisioning.  Works on AC1 and AC2"	
echo "-D "enable/disable",			Enable or Disable DNS proxy"
echo "-e " ",					See if radio resolves DNS.  SSH's to the radio and pings a domain name to see if it can resolve"
echo "-N "Device Name",				Change name of the device."
echo "-n "enable/disable",			Enable or Disable NTP server"
echo "-K SSH Key,				Specifies to path to the Public SSH Key file i.e. id_rsa.pub"
echo "-l "enable/disable",			Enable or Disable Syslog.  Specify ip address if you want to enable remote syslog"
echo "-P PSK key,				Change wireless passkey"
echo "-r KEYTODEL, 				Replace KEYTODEL with "key1"(to delete the first SSH Key), "key2"(to delete the second Key), or "allkeys"(to delete all current SSH Keys on the device)"
echo "-S SSID,				Change SSID.  Spaces are not supported in SSID field yet."
echo "-s \"community;contact;location\"	 	Enable and set SNMP"
echo "-t "enable/disable",			Enable or Disable Traffic Shaping on device, note: you cannot set the speed limits from this program."
echo "-c fromText,	   			The c and C Options are for making custom changes to the /tmp/system.cfg file, put the text you want to change after the -c option"
echo "-C toText,		   		The C and c Options are for making custom changes to the /tmp/system.cfg file, put the text you want the -c text to be changed to after the -C option.  See below example"
echo "-w Channel Width,   			Set Channel Width i.e.(-w 10) for 10mhz"
echo "-u username,	   			Change default username for the device"
echo "-U firmware,	   			Upgrade device firmware, can print current firmware version the option argument is version, info, or status"

echo ""
echo "Device Operations"
echo "-B ,					Backs up configuration of device.  Script automatically names and time stamps the backup"
echo "-b BACUPNAME,	   			Restores a backup configuration from the specified file"
echo "-I,		   			Prints info about device"
echo "-d,		   			Run Discovery on device"
echo "-R, 		   			Reboot Device"
echo "-w Channel Width,   			Changes channel width to whatever is specified, just the number no need to add mhz to the end, supported channel widths are 5,8,10,20,40 mhz"
echo "-W,		   			WIFI Scan, runs a scan, same thing as site survey"
echo "-X COMMAND,	   			Run a custom Command on device, like \"ls\", \"grep ssid /tmp/system.cfg\"  Make sure to put the command in \"\" "
echo "-y \'username,password\', 		Specify username and password to use in script"
echo "-Y, 		   			Update ubntmod script with the latest available"
echo "-z,                                       Saves changes without a reboot by executing /usr/etc/rc.d/rc.softrestart save"
echo "-Z, 		   			Saves changes made and reboots device to apply changes"
echo ""

echo ""
echo ""
echo "c and C Example"
echo ""
echo "basic usage:"
echo "./ubntmod.sh -i IPADDRESS -c linetochange -C changetoline"
echo "./ubntmod.sh -i 192.168.1.20 -c snmp.status=enabled -C snmp.status=disable"
echo "The above line changes the \"snmp.status=enabled\" to \"snmp.status=disabled\""
echo ""
echo "Find more help and tutorials at http://incredigeek.com/home/UBNTMOD"
}

# RUN Functions
if [[ ${yacontrol} = "1" ]] ; then
ACONTROL
fi

if [[ ${ylog} = "1" ]] ; then
SYSLOG
fi

if [[ ${backup} = "1" ]] ; then
BACKUP
fi

if [[ ${ydns} = "1" ]] ; then
DNS
fi

if [[ ${restore} = "1" ]] ; then
RESTORE
fi

if [[ ${yconnection} = "1" ]] ; then
CONNECTION
fi

if [[ ${name} = "1" ]] ; then
NAME
fi

if [[ ${yntp} = "1" ]] ; then
NTP
fi

if [[ ${info} = "1" ]] ; then
INFO
fi

if [[ ${reboot} = "1" ]] ; then
REBOOT
fi

if [[ ${discover} = "1" ]] ; then
DISCOVER
fi

if [[ ${help} = "1" ]] ; then
HELP
fi

if [[ ${yversion} = "1" ]] ; then
VERSION
fi

if [[ ${yssid} = "1" ]] ; then
SSID
fi

if [[ ${ypassword} = "1" ]] ; then
PASSWORD
fi

if [[ ${ypskchange} = "1" ]] ; then
PSK
fi

if [[ ${yaddsshkey} = "1" ]] ; then
ADDSSHKEY
fi

if [[ ${ydelsshkey} = "1" ]] ; then
DELSSHKEY
fi

if [[ ${comand} = "1" ]] ; then
COMAND
fi

if [[ ${ysnmp} = "1" ]] ; then
SNMP
fi

if [[ ${ytshaper} = "1" ]] ; then
TSHAPER
fi

if [[ ${yusername} = "1" ]] ; then
USERNAME
fi

if [[ ${yupgrade} = "1" ]] ; then
UPGRADE
fi

if [[ ${ychannelwidth} = "1" ]] ; then
CHANNELWIDTH
fi

if [[ ${wifiscan} = "1" ]] ; then
WIFISCAN
fi

if [[ ${xxcommand} = "1" ]] ; then
XCOMMAND
fi

if [[ ${ycommand} = "1" ]] ; then
SCRIPTUPGRADE
fi

if [[ ${softrestart} = "1" ]] ; then
SOFTRESTART
fi

if [[ ${saveandreboot} = "1" ]] ; then
SAVEREBOOT
fi
