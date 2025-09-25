#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR :: Please run this command in root privilage"
    exit 1 # failure is other than 0
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "ERROR :: Installing mysql is Failure"
    exit 1 # failure is other than 0
else
    echo "installing mysql is SUCCESS"
fi