#!/usr/bin/env bash

wtf()
{
    echo $@
    exit
}

install()
{
    local pkgs=$@

    for pkg in $pkgs; do
        dpkg -s $pkg > /dev/null 2>&1

        if [ $? -ne 0 ]; then
            apt-get install -y $pkg || wtf "Install package \'$pkg\' failed"
        else
            echo "Package \`$pkg\` already installed"
        fi
    done
}

# update source
apt-get update || exit -1

# install packages
install python python-virtualenv
install curl wget
install htop iftop
install tree
install git-core git subversion
install vim
install nginx
install postgresql

# start nginx if not started
if [ -f /etc/init.d/nginx ] && [ ! -f /var/run/nginx.pid ]; then
    /etc/init.d/nginx start || wtf "Start nginx failed"
fi
