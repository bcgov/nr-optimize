#!/bin/bash
#Test script for comparing data transfer rates between SAN and Azure Files
#Optimize team: 2020-09-17

#To run DataLoad.sh <Target SAN Test folder> <Azure Target Test Folder> <Test Data Folder> <log file folder>

#Setup vars
SAN_F=${1}
Azure_F=${2}
Test_F=${3}
Log_f=${4}
#TestToSAN=Test_F SAN_F
#SANToTest=SAN_F Test_F
#TestToAZ=Test_F Azure_F
#AZToTest=Azure_F Test_F

#Capture time stamp
echo_time() {
    echo `date +"Year: %Y, Month: %m, Day: %d, Hour: %I, Minute: %M, Second: %S, Nanosecond: %3N"`
}

echo \ >> $Log_f 
echo "SAN Target: $SAN_F AZ Target: $Azure_F Test Data Target: $Test_F Log Folder: $Log_f" >> $Log_f
echo "Time: $(echo_time)" >> $Log_f

#get a timestamp - nanoseconds since epoch
timestamp1=$(date +%s%3N)

#Move data from  test folder to SAN
time rsync -vrz --progress --ignore-existing --delete-delay $Test_F $SAN_F --log-file=$Log_f

#get another timestamp
timestamp2=$(date +%s%3N)

#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

#compare the two timestamps
let "t2SAN = ($timestamp2 - $timestamp1)"

#difference in nanoseconds
echo "Difference in Nanoseconds: $t2SAN"

#calculate floating point, requires passing to bc to get decimal. NOTE doing this with nanoseconds even shows lag in the sleep command
echo "Floating Point: ""$(($t2SAN/1000000000)) | bc -l"

echo \ >> $Log_f
#Capture time stamp
echo "Time: $(echo_time)" >> $Log_f

#get a timestamp - nanoseconds since epoch
timestamp1=$(date +%s%3N)

#Move data from SAN to Test folder
time rsync -vrz --progress --ignore-existing --delete-delay $SAN_F $Test_F --log-file=$Log_f

#get another timestamp
timestamp2=$(date +%s%3N)

#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

#compare the two timestamps
let "SAN2t = ($timestamp2 - $timestamp1)"

#difference in nanoseconds
echo "Difference in Nanoseconds: $SAN2t"

#calculate floating point, requires passing to bc to get decimal. NOTE doing this with nanoseconds even shows lag in the sleep command
echo "Floating Point: ""$(($SAN2t/1000000000)) | bc -l"

echo \ >> $Log_f
#Capture time stamp
echo "Time: $(echo_time)" >> $Log_f

#get a timestamp - nanoseconds since epoch
timestamp1=$(date +%s%3N)

#Move data from  test folder to Azure
time rsync -vrz --progress --ignore-existing --delete-delay $Test_F $Azure_F --log-file=$Log_f

#get another timestamp
timestamp2=$(date +%s%3N)

#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

#compare the two timestamps
let "t2Azure = ($timestamp2 - $timestamp1)"

#difference in nanoseconds
echo "Difference in Nanoseconds: $t2Azure"

#calculate floating point, requires passing to bc to get decimal. NOTE doing this with nanoseconds even shows lag in the sleep command
echo "Floating Point: ""$(($t2Azure/1000000000)) | bc -l"

echo \ >> $Log_f
#Capture time stamp
echo "Time: $(echo_time)" >> $Log_f

#get a timestamp - nanoseconds since epoch
timestamp1=$(date +%s%3N)

#Move data from Azure to Test folder
time rsync -vrz --progress --ignore-existing --delete-delay $Azure_F $Test_F --log-file=$Log_f

#get another timestamp
timestamp2=$(date +%s%3N)

#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

#compare the two timestamps
let "Azure2t = ($timestamp2 - $timestamp1)"

#difference in nanoseconds
echo "Difference in Nanoseconds: $Azure2t"

#calculate floating point, requires passing to bc to get decimal. NOTE doing this with nanoseconds even shows lag in the sleep command
echo "Floating Point: "$(($Azure2t/1000000000)) | bc -l"