#!/usr/bin/env zsh

set -e

DEFAULT_PKG_NAME=watchman-4.9.0-r2.apk
DEFAULT_IMG=node:14.15.4-alpine

message() {
  echo >/dev/stderr $*
}

if [ $# -eq 0 ] ; then
  img=$DEFAULT_IMG
  pkgname=$DEFAULT_PKG_NAME
elif [ $# -eq 2 ] ; then
  img=$1
  pkgname=$2
else
  message "Usage $0 <image> <package name>"
  message "image defaults to $DEFAULT_IMG"
  message package name defaults to $DEFAULT_PKG_NAME
fi

# build an image containing the package
docker build --build-arg IMG=$img -t docker-alpine .
# create a container from the image, grab the package from it, and delete the container
id=$(docker create docker-alpine)
docker cp $id:/root/packages/tmp/x86_64/watchman-4.9.0-r2.apk $pkgname
docker rm -v $id
