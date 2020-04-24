#!/bin/bash

#Run as sudo
#first argument is the interface
#second argument is the duration
#thrid argument is the file location

rm -f $3;
touch $3;
chmod o=rw $3;
tshark -i $1 -a duration:$2 -w $3;
