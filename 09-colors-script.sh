#!/bin/bash

G="\e[31m"
R="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR :: Please run this command in root privilage"
    exit 1 # failure is other than 0
fi

VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "ERROR :: Installing $2 is $R Failure $N"
        exit 1 # failure is other than 0
    else
        echo -e "installing $2 is $G SUCCESS $N"
    fi
}

dnf list installed mysql
# install if it is not found
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo -e "MuSql is already exist $Y SKIPPING $N"
fi

dnf list installed nginx
# install if it is not found
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "Nginx"
else
    echo -e "Nginx is already exist $Y SKIPPING $N"
fi

dnf list installed mysql
# install if it is not found
if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? "Python3"
else
    echo -e "Python is already exist $Y SKIPPING $N"
fi