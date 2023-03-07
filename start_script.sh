#!/bin/bash

set -e
FILESIGNATURE=$(sed -i "s/'.asm'/'.bin'" $1)

echo $FILESIGNATURE

nasm -f bin $1 -o $FILESIGNATURE

qemu-system-x86_64 $FILESIGNATURE

