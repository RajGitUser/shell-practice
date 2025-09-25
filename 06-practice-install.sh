#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR :: Please run this command in root privilage"
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "ERROR :: Installing mysql is Failure"
else
    echo "installing mysql is SUCCESS"
fi