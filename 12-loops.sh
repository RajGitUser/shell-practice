#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[34m"
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -fi )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo "ERROR :: Please Run this command in SUDO privilage"
exit1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "installing $2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "installing $2 ... $N SUCCESS $N"
    fi
}

# $@

for package in $@
do
    dnf list installed $package &>>$LOG_FILE

    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$package is already installed $Y SKIPPING $N"
    fi
done


