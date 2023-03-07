#!/bin/bash

#set -e

FILESIGNATURE=$(echo $1 | sed "s/.asm/.bin/")

echo $FILESIGNATURE

nasm -f bin $1 -o $FILESIGNATURE

qemu-system-x86_64 $FILESIGNATURE

