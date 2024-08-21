#!/bin/bash

# Threshold for resource usage (in percentage)
THRESHOLD=60

# Function to check memory usage
check_memory() {
    memory_usage=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
    echo "Memory usage: $memory_usage%"
    if [ "$memory_usage" -gt "$THRESHOLD" ]; then
        echo "Memory usage is above $THRESHOLD%"
        exit 1
    fi
}

# Function to check CPU usage
check_cpu() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU usage: $cpu_usage%"
    if [ "$(echo "$cpu_usage > $THRESHOLD" | bc)" -eq 1 ]; then
        echo "CPU usage is above $THRESHOLD%"
        exit 1
    fi
}

# Function to check disk usage
check_disk() {
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Disk usage: $disk_usage%"
    if [ "$disk_usage" -gt "$THRESHOLD" ]; then
        echo "Disk usage is above $THRESHOLD%"
        exit 1
    fi
}

# Execute the resource checks
check_memory
check_cpu
check_disk

echo "All resources are within acceptable limits."
exit 0
