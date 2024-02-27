#!/usr/bin/env bash
# this script verifies that a domain exists
echo "file? (y/n)"
read -r input
if [ "$input" = "y" ]; then
	path=$(dirname "$(dirname "$0")")/2-setup_a_domain_name
	domain=$(cat "$path")
else
	echo "Enter the domain"
	read -r domain
fi

echo "Verifying that the domain $domain exists"
dig "$domain" | grep "ANSWER: 0" && echo "The domain does not exist" || echo "The domain exists"
