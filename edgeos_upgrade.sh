
#!/bin/bash 
 
 
#------------------------------------------------------------------------------- 
STATUS_FILE="/var/run/fw-latest-status" 
UPGRADING_FILE="/var/run/upgrading" 
REBOOT_NEEDED_FILE="/var/run/needsareboot" 
DOWNLOADING_FILE="/var/run/downloading" 
URL="https://fw-update.ubnt.com/api/firmware-latest" 
ACTION="refresh" 
CHANNEL="release" 
DEFAULT_URL="https://localhost/eat/my/shorts.tar" 
 
 
#------------------------------------------------------------------------------- 
while [[ $# -gt 0 ]] 
do 
    key="$1" 
    case $key in 
        -r|--refresh)           # Refresh status of latest firmware by 
        ACTION="refresh"        # fetching it from fw-update.ubnt.com 
        shift 
        ;; 
        -s|--status)            # Read latest firmware status from cache 
        ACTION="status" 
        shift 
        ;; 
        -u|--upgrade)           # Upgrade to latest firmware 
        ACTION="upgrade" 
        shift 
        ;; 
        -c|--channel)           # Target channel (release or public-beta) 
        CHANNEL="$2" 
        shift 
        shift 
        ;; 
        *)                      # Ignore unknown arguments 
        shift 
        ;; 
esac 
done 
# ... 
upgrade_firmware() {                                                                                   
    # Fetch version number of latest firmware                                                                       
    echo -n "Fetching version number of latest firmware... "                                             
    refresh_status_file @> /dev/null                                                                     
                                              
    # Parse status file                                                   
    local fw_version=`cat $STATUS_FILE | jq -r .version 2> /dev/null` || fw_version="" 
    local fw_url=`cat $STATUS_FILE | jq -r .url 2> /dev/null` || fw_version="" 
    local fw_md5=`cat $STATUS_FILE | jq -r .md5 2> /dev/null` || fw_version=""                       
    local fw_state=`cat $STATUS_FILE | jq -r .state 2> /dev/null` || fw_version="" 
    if [ -z "$fw_version" ] || [ "$fw_url" = "$DEFAULT_URL" ]; then 
        echo "failed"                                                            
        exit 42                                                                  
    else                
        echo "ok"                                                                
        echo " > version : $fw_version"                                                                
        echo " > url     : $fw_url"                                                        
        echo " > md5     : $fw_md5"                                    
        echo " > state   : $fw_state"                                 
        echo                                                                     
    fi                            
                                                                                 
    if [ "$fw_state" == "can-upgrade" ]; then                                    
        echo "New firmware $fw_version is available"                                                     
        echo                               
        sudo /usr/bin/ubnt-upgrade --upgrade-force-prompt "$fw_url"                  
                                                                                 
    elif [ "$fw_state" == "up-to-date" ]; then 
        echo "Current firmware is already up-to-date (!!!)" 
        echo                                                              
        sudo /usr/bin/ubnt-upgrade --upgrade-force-prompt "$fw_url"                                      
                                           
    elif [ "$fw_state" == "reboot-needed" ]; then                                
        echo "Reboot is needed before upgrading to version $fw_version" 
                                                           
    else                    
        echo "Upgrade is already in progress" 
    fi                                                                                 
}                                                                              
                                                                                 
#-------------------------------------------------------------------------------   
if [ "$ACTION" == "refresh" ]; then                                 
    refresh_status_file                                       
                                   
elif [ "$ACTION" == "status" ]; then 
    read_status_file                                                             
                                                                                 
elif [ "$ACTION" == "upgrade" ]; then                                                      
    upgrade_firmware                  
fi
