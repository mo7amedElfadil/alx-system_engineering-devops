#!/usr/bin/env bash
# executes file 0-transfer_file with args
path=$(dirname "$(dirname "$0")")/0-transfer_file
FILE=some_page.html
IP=$SERVER
USER=ubuntu
path_to_ssh_key=~/.ssh/id_rsa

echo "checking if file exists remotely"
ssh -i "$path_to_ssh_key" "$USER@$IP" "test -f ~/$FILE"
if [ $? -eq 0 ]; then
	echo "file exists remotely"
	exit 0
else
	echo "file does not exist remotely"
fi

echo "Checking if file exists locally"
if [ -f $FILE ]; then
	echo "file exists locally"
else
	echo "file does not exist locally"
	echo "Creating file locally"
	touch $FILE
fi


echo "Executing $path with arguments"
"$path" "$FILE" "$IP" "$USER" "$path_to_ssh_key"
if [ $? -eq 0 ]; then
	echo "File transferred successfully"
else
	echo "File transfer failed"
	exit 1
fi

echo "Checking if file exists remotely again"
ssh -i "$path_to_ssh_key" "$USER@$IP" "test -f ~/$FILE"
if [ $? -eq 0 ]; then
	echo "file exists remotely"
	ssh -i $path_to_ssh_key $USER@$IP 'ls ~/'
else
	echo "file does not exist remotely"
	ssh -i $path_to_ssh_key $USER@$IP 'ls ~/'
	exit 1
fi


