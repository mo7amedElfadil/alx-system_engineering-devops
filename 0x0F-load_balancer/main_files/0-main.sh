#!/usr/bin/env bash

path=$(dirname "$(dirname "$0")")/transfer_file
installer=0-custom_http_response_header
if [ "$#" -eq 1 ]; then
	if [ "$1" == 1 ]; then
		IP=$SERVER1
	else
		IP=$SERVER2
	fi
else
	IP=$SERVER2
fi
USER=ubuntu
path_to_ssh_key=~/.ssh/id_rsa

echo "Executing $path with arguments on server $IP"
"$path" "$installer" "$IP" "$USER" "$path_to_ssh_key"
if [ $? -eq 0 ]; then
    echo "File transferred successfully"
else
    echo "File transfer failed"
    exit 1
fi

echo "Checking if file exists remotely"
ssh -i "$path_to_ssh_key" "$USER@$IP" "test -f ~/$installer"
if [ $? -eq 0 ]; then
    echo "file exists remotely. Executing the file...?"
	if [ "$1" == '-y' ]; then
		REPLY='y'
	else
		read -p "install? (y/n) " -n 1 -r
	fi
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		ssh -i $path_to_ssh_key $USER@$IP "./$installer; rm -f ~/$installer"
	else
		echo "file exists remotely. Not executing the file"
	fi
else
    echo "file does not exist remotely"
    ssh -i $path_to_ssh_key $USER@$IP 'ls ~/'
    exit 1
fi

if curl -s "$IP" | grep -q "Hello World!"; then
	echo "nginx is installed and running"
else
	echo "nginx is not running"
	exit 1
fi

if curl_output=$(curl -sI "$IP/redirect_me" | head -n 1); then
    if echo "$curl_output" | grep -q "HTTP/1.1 301 Moved Permanently"; then
        echo "Redirect is working"
    else
        echo "Expected redirect status not found in the first line of HTTP response"
        exit 1
    fi
else
    echo "Failed to retrieve HTTP response"
    exit 1
fi

if curl_output=$(curl -sI "$IP/not_found" | head -n 1); then
	if echo "$curl_output" | grep -q "HTTP/1.1 404 Not Found"; then
		echo "404 is working"
	else
		echo "Expected 404 status not found in the first line of HTTP response"
		exit 1
	fi
else
	echo "Failed to retrieve HTTP response"
	exit 1
fi

if curl_output=$(curl -sI "$IP" | grep "X-Served-By"); then
	echo "X-Served-By header is present"
else
	echo "X-Served-By header is not present"
	exit 1
fi
