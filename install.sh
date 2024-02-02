#!/bin/bash

function isroot() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please try runnig the script as sudo"
        exit 1
    fi

    repositories
}

function repositories () {
    echo ""

    echo "Updating repositories"

    if sudo apt-get update &> /dev/null; then
        echo -e "   ➥\e[32mSuccessfully\e[0m updated the repositories!"
    fi

    install
}

function install (){
    echo ""

    echo "Installing needed programs"

    if sudo apt-get install nginx -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed NGINX!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install NGINX"
    fi

    if sudo apt-get install mysql-server -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed MySQL!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install MySQL"
    fi

    if sudo apt-get install phpmyadmin -y > /dev/null 2>&1; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed PhpMyAdmin!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install PhpMyAdmin"
    fi
}

isroot