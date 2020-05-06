#!/bin/bash

read -p "Enter Your Name: "  username
read -p "Enter ip: "  ip
read -s -p "Enter Password: " pswd

echo "Welcome $username!"
echo $pswd

ssh $username@$ip

#apt-get update -y && apt-get upgrade -y