#!/bin/bash

function isroot() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please try runnig the script as sudo"
        exit 1
    fi

    checkos
}

function checkos() {
    echo ""

    # Check for /etc/debian_version file
    if [ -f "/etc/debian_version" ]; then
        echo "This script can be used on your distribution."
    exit 0
    fi

    # Backup check: Look for some core Debian utilities
    if command -v apt-get &>/dev/null && command -v dpkg &>/dev/null; then
        echo "This script can be used on your distribution."
    exit 0
    fi

    echo "This script is intended for Debian-based distributions only."
    exit 1

    echo ""

    repositories
}

function repositories () {
    echo ""

    echo "Updating repositories"

    if sudo apt update &> /dev/null; then
        echo -e "   ➥\e[32mSuccessfully\e[0m updated the repositories!"
    fi

    install
}

function install (){
    echo ""

    echo "Installing needed programs"

    if sudo apt install nginx -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed NGINX!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install NGINX"
    fi

    if sudo apt install mysql-server -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed MySQL!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install MySQL"
    fi

    if sudo apt install phpmyadmin -y > /dev/null 2>&1; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed PhpMyAdmin!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install PhpMyAdmin"
    fi
}

isroot