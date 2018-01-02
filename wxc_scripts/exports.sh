#!/bin/sh

#This file used for exports.

export PI_MASTER="10.70.20.1"
export PI_SLAVE="192.168.1.2"
export VPS="athenacle.xyz"
export VPS_SSH_PORT="60606"
export VPS_USERNAME="root"
export PI_USERNAME="wangxiao"
export ShadowPORT="${PI_MASTER}:8090"
export GIT_SERVER=$PI_SLAVE
export GIT_USERNAME="git"
#export CDPATH=".:/home/wangxiao"

#export PATH="${PATH}:/etc/java-config-2/current-system-vm/bin/"
export ANDROID_HOME="/home/wangxiao/Android/Sdk/"
#export GOROOT_BOOTSTRAP="/home/wangxiao/go"
export GOROOT_BOOTSTRAP="/usr/lib/go"
export ANDROID_ROM_HOME="${ANDROID_HOME}/../Rom"
alias repo="python2 ${ANDROID_ROM_HOME}/repo"

export TERM="xterm-256color"
#export PATH="/home/wangxiao/bin/:${PATH}"
export GOPATH='/home/wangxiao/.go/'
