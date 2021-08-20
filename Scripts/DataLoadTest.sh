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
#Move data from  test folder to SAN
time rsync -vr --progress $Test_F $SAN_F --log-file=$Log_f
#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

echo \ >> $Log_f
#Capture time stamp
echo "Time: $(echo_time)" >> $Log_f
#Move data from SAN to Test folder
time rsync -n -vr --progress $SAN_F $Test_F --log-file=$Log_f
#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

echo \ >> $Log_f
#Capture time stamp
echo "Time: $(echo_time)" >> $Log_f
#Move data from  test folder to Azure
time rsync -n -vr --progress $Test_F $Azure_F --log-file=$Log_f
#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f

echo \ >> $Log_f
#Capture time stamp
echo "Time: $(echo_time)" >> $Log_f
#Move data from Azure to Test folder
time rsync -n -vr --progress $Azure_F $Test_F --log-file=$Log_f
#Measure Operation Time
echo "Time: $(echo_time)" >> $Log_f