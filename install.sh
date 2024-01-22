#!/bin/bash

function isroot () {
    if [[ $EUID -ne 0]]: then
        echo "Please try running the script as root"
        exit 1
    fi

    repositories
}

function repositories () {
    ehco ""

    ehco "Updating repositories"

    if sudo apt-get update &> /dev/null; then
        echo -e "   ➥\e[32mSuccessfully\e[0m updated the repositories!"
    fi

    install
}

echo ""

echo "Install needed programs"

if sudo apt-get install nginx -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed NGINX!"
else
    echo -e "   ➥\e[31mFailed\e[0m installed NGINX"
fi

if sudo apt-get install phpmyadmin -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed PhpMyAdmin!"
else
    echo -e "   ➥\e[31mFailed\e[0m installed PhpMyAdmin"
fi

isroot