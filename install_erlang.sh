#!/bin/bash

ID=$(cat /etc/os-release | awk -F= '/^ID=/{print $2}' | tr -d '"')

case "${ID}" in
  centos|rhel)
    sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
    sudo yum -y install erlang-solutions-1.0-1.noarch.rpm
    sudo yum -y install erlang
    ;;
  *)
    echo "Distro '${ID}' not supported" 2>&1
    exit 1
    ;;
esac
