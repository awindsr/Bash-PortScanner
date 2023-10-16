#!/bin/bash

# Default values
ip=""
ports=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i | --ip)
            ip="$2"
            shift
            ;;
        -p | --ports)
            ports="$2"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Check if required options are provided
if [[ -z $ip ]]; then
    echo "Please specify an IP address with -i"
    exit 1
fi

if [[ -z $ports ]]; then
    echo "Please specify the max port range with -p"
    exit 1
fi

# Scan and display open ports
for ((i = 1; i <= ports; i++)); do
    if (echo > /dev/tcp/$ip/$i) > /dev/null 2>&1; then
        echo "$ip:$i is open"
    fi
done
