#!/usr/bin/bash
export NEWT_COLORS='
#window=,red
#border=white,red
#textbox=white,red
#button=black,white
#label=blue, white
'
API_KEY="5161aefcb6cb2b289686365bb1c46daa"
RPC_PORT="9009"
RPC_HOST="http://localhost"
node_address=$(envsubst < node_address | bash) 
node_status=$(envsubst < node_status | bash)

current_block=$(envsubst < current_block | bash)
highest_block=$(envsubst < highest_block | bash)

function import_api {

API_KEY=$(whiptail --inputbox "What is your API Key?" 8 39 --title "API Key Import Dialog" 3>&1 1>&2 2>&3)
                                                                        # A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $API_KEY
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
	}

	       
menu=$(whiptail --backtitle "Current block: $current_block Highest block: $highest_block" --title "Idena node management" --menu "Node ID: $node_address Sync Status: $node_status" 25 78 5 \
"API_key:" "In case if you already have it" \
"Private_key:" "In case if you have it" \
"Terminal_layout:" "Idena node real time log output" \
"Activate_mining:" "Mining status ON" \
"Deactivate_mining:" "Mining status OFF" 3>&2 2>&1 1>&3)
echo $menu

