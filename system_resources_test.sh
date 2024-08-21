#!/bin/bash

# Define the threshold percentage
THRESHOLD=60

# Function to check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    CPU_EXCEEDS=0
    if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
        CPU_EXCEEDS=1
    fi
    echo "CPU: $CPU_USAGE% $( [ $CPU_EXCEEDS -eq 1 ] && echo "(Error Code 1)")"
    return $CPU_EXCEEDS
}

# Function to check Memory usage
check_memory() {
    MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    MEM_EXCEEDS=0
    if (( $(echo "$MEM_USAGE > $THRESHOLD" | bc -l) )); then
        MEM_EXCEEDS=1
    fi
    echo "Memory: $MEM_USAGE% $( [ $MEM_EXCEEDS -eq 1 ] && echo "(Error Code 1)")"
    return $MEM_EXCEEDS
}

# Function to check Disk usage
check_disk() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    DISK_EXCEEDS=0
    if (( DISK_USAGE > THRESHOLD )); then
        DISK_EXCEEDS=1
    fi
    echo "Disk: $DISK_USAGE% $( [ $DISK_EXCEEDS -eq 1 ] && echo "(Error Code 1)")"
    return $DISK_EXCEEDS
}

# Run the checks
check_cpu
CPU_STATUS=$?

check_memory
MEM_STATUS=$?

check_disk
DISK_STATUS=$?

# If any of the checks exceed the threshold, exit with code 1
if [ $CPU_STATUS -eq 1 ] || [ $MEM_STATUS -eq 1 ] || [ $DISK_STATUS -eq 1 ]; then
    exit 1
else
    exit 0
fi









