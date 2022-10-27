#!/bin/bash
ARMER_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
username=$(echo "$ARMER_DIR" | awk -F\/ '{print $3}')
if [ -d "/home/$username/idena-coacher" ]
then
        echo "Looking for available IDENA Coacher updates..."
else
        echo "Error: IDENA Coacher is not installed."
        exit
fi

cd /home/$username/idena-coacher
if [[ $(git pull | grep 'Already up to date') ]]; then
  echo "You already have the latest version"
  exit
fi
echo "IDENA Coacher has been successfully updated."
exit
