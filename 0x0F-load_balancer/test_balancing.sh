#!/bin/bash
# run loop 10 times
for _ in {1..10}
do
	echo "$(curl -sI "$SERVER3LB" | grep "X-Served-By")"
done
