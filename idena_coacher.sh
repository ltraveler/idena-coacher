#!/usr/bin/bash
TERM=linux
clear
#
ARMER_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
username=$(echo "$ARMER_DIR" | awk -F\/ '{print $3}')
PRIVATE_PATH="/home/$username/idena-go/datadir/keystore/nodekey"
PRIVATE_KEY=$(cat "$PRIVATE_PATH")
API_PATH="/home/$username/idena-go/datadir/api.key"
LOG_PATH="/home/$username/idena-go/idena_screen.log"
export API_KEY=$(cat $API_PATH)
export RPC_PORT="9009"
export RPC_HOST="http://localhost"

node_address=$(envsubst < ./api/node_address | bash) 
node_status=$(envsubst < ./api/node_status | bash)
current_block=$(envsubst < ./api/current_block | bash)
highest_block=$(envsubst < ./api/highest_block | bash)

dna_status=$(envsubst < ./api/dna_status | bash)


function importPkey {

IBOX_KEY=$(dialog --colors --backtitle "\Zb\Z5Your current key: \Zu\Z3$PRIVATE_KEY\Zn" --title "Private Key Import Dialog" --inputbox "Enter your nodekey?"  8 39  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ] && [ -n "$IBOX_KEY" ] && [ "$PRIVATE_KEY" != "$IBOX_KEY" ]; then
#echo "Updating your Private Key to $PRIVATE_KEY"
    service idena stop
    echo "$IBOX_KEY" > "$PRIVATE_PATH"
    service idena start
else
    dialog --title "Private key import" --clear --msgbox "Private key import aborted. No changes were made." 10 41
fi

echo "(Exit status: $exitstatus)"
	}

function showLog {

	dialog --colors --ascii-lines --tailbox "$LOG_PATH" 60 160

	}

function dashRefresh {

		PRIVATE_KEY=$(cat "$PRIVATE_PATH")
		node_address=$(envsubst < ./api/node_address | bash)
		node_status=$(envsubst < ./api/node_status | bash)
		current_block=$(envsubst < ./api/current_block | bash)
		highest_block=$(envsubst < ./api/highest_block | bash)
		dna_status=$(envsubst < ./api/dna_status | bash)
	}

###
while [ 1 ]
do
CHOICE=$(
dialog --colors --clear --backtitle "\Zb\Z5Current block: \Zu\Z3$current_block\Zn \Zb\Z5Highest block: \Zu\Z3$highest_block\Zn \Zb\Z5Mining Status: \Zu\Z3$dna_status\Zn"  --title "Idena node management" --menu "Node ID: $node_address Sync Status: $node_status" 25 78 5 \
	"1)" "Show Private Key."  \
	"2)" "Import Private Key."  \
	"3)" "Terminal layout."  \
	"4)" "Activate mining." \
	"5)" "Deactivate mining." \
	"6)" "Send IDNA."  3>&2 2>&1 1>&3	
)

if [ $? -gt 0 ]; then 
        break
fi

case $CHOICE in
	"1)")   
		dashRefresh
		dialog --colors --title "Hello" --msgbox "Address:\n\Zu\Z4$node_address\Zn\n\nPrivate key:\n\Zu\Z4$PRIVATE_KEY\Zn" 10 80
	;;
	"2)")   
		importPkey
		dashRefresh
	;;

	"3)")   
		showLog
		dashRefresh
        ;;

	"4)")   
		#dialog --colors --msgbox "Under development" 20 78
		envsubst < ./api/mining_on | bash
		for ((i=0;i<=100;i+=10)); do echo $i; sleep 3; done | dialog --gauge "Please wait 30 seconds." 0 0
		dashRefresh
        ;;

	"5)")   
             	#dialog --colors --msgbox "Under development" 20 78 
		envsubst < ./api/mining_off | bash
		for ((i=0;i<=100;i+=10)); do echo $i; sleep 3; done | dialog --gauge "Please wait 30 seconds." 0 0
                dashRefresh
        ;;

	"6)")   
		dialog --colors --msgbox "Under development" 20 78	
        ;;

esac
done
clear
exit

