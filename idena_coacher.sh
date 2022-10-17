#!/usr/bin/bash
#
#Checking if req packages are installed
reqpkgs=('jq' 'dialog' 'nano' 'netcat-traditional' 'gettext-base')
for x in "${reqpkgs[@]}"; do
dpkg -s "$x" &> /dev/null
if [ $? != 0 ]; then
    echo -e "${LRED}Package $x is not instlled. Installing...${NC}"
    apt-get install -y $x; 
fi
done
#
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

export node_address=$(envsubst < ./api/node_address | bash) 
node_status=$(envsubst < ./api/node_status | bash)
current_block=$(envsubst < ./api/current_block | bash)
highest_block=$(envsubst < ./api/highest_block | bash)
current_balance=$(envsubst < ./api/get_balance | bash)

dna_status=$(envsubst < ./api/dna_status | bash)

function delayProgress {

                for ((i=0;i<=100;i+=10)); do echo $i; sleep 3; done | dialog --gauge "Please wait 30 seconds." 0 0

}

function importPkey {

IBOX_KEY=$(dialog --colors --backtitle "\Zb\Z5Your current key: \Zu\Z3$PRIVATE_KEY\Zn" --title "Private Key Import Dialog" --inputbox "Enter your nodekey?"  8 39  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ] && [ -n "$IBOX_KEY" ] && [ "$PRIVATE_KEY" != "$IBOX_KEY" ]; then
#echo "Updating your Private Key to $PRIVATE_KEY"
    service idena stop
    echo "$IBOX_KEY" > "$PRIVATE_PATH"
    service idena start > /dev/null
    for ((i=0;i<=100;i+=10)); do echo $i; sleep 6; done | dialog --gauge "Please wait 60 seconds." 0 0
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
		export node_address=$(envsubst < ./api/node_address | bash)
		node_status=$(envsubst < ./api/node_status | bash)
		current_block=$(envsubst < ./api/current_block | bash)
		highest_block=$(envsubst < ./api/highest_block | bash)
		dna_status=$(envsubst < ./api/dna_status | bash)
		current_balance=$(envsubst < ./api/get_balance | bash)
	}

function sendDNA {

#
#
#

destination_address=""
transaction_amount=""

# open fd
exec 3>&1

# Store transaction details
export VALUES=$(dialog --colors --ok-label "Send" \
	  --backtitle "Measure payee address thrice and send once! \Z1\ZbATTENTION:\ZB\Zn \Z3\ZbThere is no way\Zn to cancel the transaction after clicking \Z1Send\Zn button!\ZB" \
	  --title "$node_address" \
	  --form "\Z1Transaction details:\Zn" \
15 70 0 \
	"Destination:" 1 1	"$destination_address" 	1 15 42 0 \
	"Amount:"    2 1	"$transaction_amount"  	2 15 42 0 \
2>&1 1>&3)
exitstatus=$?
# close fd
exec 3>&-
echo $VALUES
export destination_address=`echo $VALUES | awk '{print $1}'`
export transaction_amount=`echo $VALUES | awk '{print $2}'`
	
if [[ $exitstatus = 0 ]] && [[ -n "$destination_address" ]] && [[ "$destination_address" =~ ^0x[0-9a-fA-F]{40}$ ]] && [[ -n "$transaction_amount" ]] && [[ "$transaction_amount" =~ ^[0-9]+$ ]]; then

	transaction_hash=$(envsubst < ./api/send_dna | bash)
	for ((i=0;i<=100;i+=10)); do echo $i; sleep 3; done | dialog --gauge "Please wait 30 seconds." 0 0
	dialog --colors --title "Transaction has been sent" --clear --msgbox "\Zb\Z3Destination:\ZB\n\Zu\Z0$destination_address\Zn\n\n\Zb\Z3Amount:\ZB\n\Zu\Z0$transaction_amount\Zn\n\n\Zb\Z3Transaction hash:\ZB\n\Zu\Z0$transaction_hash\Zn" 10 80 
	dashRefresh

else

	dialog --colors --title "Oops, something went wrong..." --clear --msgbox "\Z1Please check one of the following conditions:\ZB\Zn\n\n1. You may have entered an incorrect payee \Z4iDNA\Zn address.\n2. You may have entered an incorrect \Z4iDNA\Zn amount.\n3. The \Z5ESC\Zn or \Z5Cancel\Zn button has been pressed." 10 80

fi

}
###
#checking if idena-go client is running
if ! ( nc -zv localhost $RPC_PORT 2>&1 >/dev/null ); then
dialog --colors --title "Oops, something went wrong..." --clear --msgbox "\Z1The port \Z4$RPC_PORT\Zn \Z1is closed!\Zn\n\nPlease check if the \Zb\Z4RPC_PORT\Zn\ZB variable has the correct port number and your \Z4idena-go\Zn node client is successfully running." 10 80
clear
exit 1
fi
###
while [ 1 ]
do
CHOICE=$(
dialog --colors --clear --backtitle "\Zb\Z5Current block: \Zu\Z3$current_block\Zn \Zb\Z5Highest block: \Zu\Z3$highest_block\Zn \Zb\Z5Current Balance: \Zu\Z3$current_balance\Zn \Zb\Z5Mining Status: \Zu\Z3$dna_status\Zn"  --title "Idena Node Management Tool by \ZB\Z5LTraveler\Zb\Zn" --menu " \Zb\Z3Node ID: \ZB\Z0$node_address\Zb\Zn  \Zb\Z3Sync Status: \ZB\Z0$node_status\Zb\Zn" 14 78 5 \
	"1)" "Show Private Key"  \
	"2)" "Import Private Key"  \
	"3)" "Terminal Layout"  \
	"4)" "Activate Mining" \
	"5)" "Deactivate Mining" \
	"6)" "Send IDNA" \
       	"7)" "About IDENA Coacher" 3>&2 2>&1 1>&3	
)

if [ $? -gt 0 ]; then 
        break
fi

case $CHOICE in
	"1)")   
		dashRefresh
		dialog --colors --title "IDENA Node Wallet Info" --msgbox "\Zb\Z3Address:\ZB\n\Zu\Z0$node_address\Zn\n\n\Zb\Z3Private key:\ZB\n\Zu\Z0$PRIVATE_KEY\Zn" 10 80
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
		delayProgress
		dashRefresh
        ;;

	"5)")   
             	#dialog --colors --msgbox "Under development" 20 78 
		envsubst < ./api/mining_off | bash
		delayProgress
                dashRefresh
        ;;

	"6)")   
		#dialog --colors --msgbox "Under development" 20 78	
		sendDNA
		dashRefresh
        ;;
	"7)")
		dialog --colors --title "IDENA Coacher by LTraveler: (\Zb\Z6t.me/ltrvlr\Zn\ZB)" --msgbox "\nBash implementation of the localhost node management tool with the following features:\n✧ \Z5Status\Zn ✧ \Z3\ZbMining ON/OFF\Zn\ZB ✧ \Z1Key change\Zn ✧ \Zb\Z4Send iDNA\Zn\ZB ✧\n\n✦ \Z7GitHub Repository:\Zn \Zb\Z7https://github.com/ltraveler/idena-coacher\Zn\n✧ \Z7Version:\Zn \Zb\Z70.1.2\Zn\ZB\n✦ \Z7Any donations are welcome:\Zn \Zb\Z70xf041640788910fc89a211cd5bcbf518f4f14d831\Zn\ZB\n✧ \Z7Telegram support:\Zn \Zb\Z7https://t.me/ltrvlr\Zn\ZB" 13 91
	;;

esac
done
clear
exit

