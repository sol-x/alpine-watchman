#!/usr/bin/env zsh

set -e

# x86_64 or aarch64
DEFAULT_ARCH=x86_64
DEFAULT_PKG_NAME=watchman-4.9.0-r2.apk
DEFAULT_IMG=node:14.15.4-alpine

message() {
  echo >/dev/stderr $*
}

if [ $# -eq 0 ] ; then
  img=$DEFAULT_IMG
  pkgname=$DEFAULT_PKG_NAME
  arch=$DEFAULT_ARCH
elif [ $# -eq 3 ] ; then
  img=$1
  pkgname=$2
  arch=$3
else
  message "Usage $0 <image> <package name> <arch>"
  message "image defaults to $DEFAULT_IMG"
  message "package name defaults to $DEFAULT_PKG_NAME"
  message "arch defaults to $DEFAULT_ARCH"
fi

# build an image containing the package
docker build --build-arg IMG=$img -t docker-alpine .
# create a container from the image, grab the package from it, and delete the container
id=$(docker create docker-alpine)
mkdir -p $arch
docker cp $id:/root/packages/tmp/$arch/watchman-4.9.0-r2.apk $arch/$pkgname
docker rm -v $id
