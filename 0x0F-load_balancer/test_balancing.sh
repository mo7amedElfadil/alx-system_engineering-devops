#!/bin/bash
# run loop 10 times
echo "Server 1"
for _ in {1..5}
do
	echo "$(curl -sI "$SERVER1" | grep "X-Served-By")"
done
echo
echo "Server 2"
for _ in {1..5}
do
	echo "$(curl -sI "$SERVER2" | grep "X-Served-By")"
done

echo
echo "Server 3 LOAD BALANCER"
for _ in {1..10}
do
	res=$(curl -sI "$SERVER3LB")
	if echo "$res" | grep -q "X-Served-By"; then
		res=$(echo "$res" | grep  "X-Served-By")
		echo -e "${COLOR_GREEN} $res ${RESET}"
	else
		res=$(echo "$res" | grep  "x-served-by")
		echo -e "${COLOR_RED} $res ${RESET}"
	fi
done
