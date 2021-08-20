#!/bin/bash

#get a timestamp - nanoseconds since epoch
timestamp1=$(date +%s%N)
echo $timestamp1

#pause the script - emulate file transfer
sleep 2

#get another timestamp
timestamp2=$(date +%s%N)
echo $timestamp2

#compare the two timestamps
let "tdiff = ($timestamp2 - $timestamp1)"

#difference in nanoseconds
echo $tdiff

#calculate floating point, requires passing to bc to get decimal. NOTE doing this with nanoseconds even shows lag in the sleep command
echo $tdiff/1000000000 | bc -l