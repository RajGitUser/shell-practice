#!/bin/bash

G="\e[31m"
R="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR :: Please run this command in root privilage"
    exit 1 # failure is other than 0
fi

mkdir -p $LOGS_FOLDER


VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 ... $R FAILURE $N"
        exit 1 # failure is other than 0
    else
        echo -e "installing $2 ... $G SUCCESS $N"
    fi
}

dnf list installed mysql &>>$LOG_FILE
# install if it is not found
if [ $? -ne 0 ]; then
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "mysql"
else
    echo -e "MuSql is already exist $Y SKIPPING $N"
fi

dnf list installed nginx &>>$LOG_FILE
# install if it is not found
if [ $? -ne 0 ]; then
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "Nginx"
else
    echo -e "Nginx is already exist $Y SKIPPING $N"
fi

dnf list installed mysql &>>$LOG_FILE
# install if it is not found
if [ $? -ne 0 ]; then
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "Python3"
else
    echo -e "Python is already exist $Y SKIPPING $N"
fi