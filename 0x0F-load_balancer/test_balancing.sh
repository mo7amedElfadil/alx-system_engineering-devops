#!/bin/bash
# run loop 10 times
echo "Server 1"
for _ in {1..10}
do
	echo "$(curl -sI "$SERVER1" | grep "X-Served-By")"
done
echo
echo "Server 2"
for _ in {1..10}
do
	echo "$(curl -sI "$SERVER2" | grep "X-Served-By")"
done
echo "Server 3 LOAD BALANCER"

for _ in {1..10}
do
	echo "$(curl -sI "$SERVER3LB" | grep "X-Served-By")"
done
