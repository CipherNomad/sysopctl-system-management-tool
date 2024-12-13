#!/bin/bash

VERSION="v0.1.0"

# Help Option
if [[ "$1" == "--help" ]]; then
    cat << EOF
sysopctl $VERSION - A system administration tool for managing services, processes, and resources.

Usage:
  sysopctl [COMMAND] [ARGUMENTS]

Commands:
  service list           List all running services.
  system load            Show system load averages.
  service start <name>   Start a service.
  service stop <name>    Stop a service.
  disk usage             Display disk usage statistics.
  process monitor        Monitor system processes.
  logs analyze           Analyze system logs.
  backup <path>          Backup system files.

Examples:
  sysopctl service list
  sysopctl service start apache2
  sysopctl disk usage
  sysopctl backup /home/user
EOF
    exit 0
fi

# Version Information
if [[ "$1" == "--version" ]]; then
    echo "sysopctl $VERSION"
    exit 0
fi

# List Running Services
if [[ "$1" == "service" && "$2" == "list" ]]; then
    echo "Listing all running services..."
    systemctl list-units --type=service
    exit 0
fi

# View System Load
if [[ "$1" == "system" && "$2" == "load" ]]; then
    echo "System load averages: "
    uptime
    exit 0
fi

# Start and Stop System Services
if [[ "$1" == "service" && "$2" == "start" && -n "$3" ]]; then
    echo "Starting service $3..."
    systemctl start "$3"
    exit 0
fi

if [[ "$1" == "service" && "$2" == "stop" && -n "$3" ]]; then
    echo "Stopping service $3..."
    systemctl stop "$3"
    exit 0
fi

# Check Disk Usage
if [[ "$1" == "disk" && "$2" == "usage" ]]; then
    echo "Disk usage statistics:"
    df -h
    exit 0
fi

# Monitor System Processes
if [[ "$1" == "process" && "$2" == "monitor" ]]; then
    echo "Monitoring system processes..."
    top
    exit 0
fi

# Analyze System Logs
if [[ "$1" == "logs" && "$2" == "analyze" ]]; then
    echo "Analyzing system logs..."
    journalctl --since "1 day ago" | grep -i "error"
    exit 0
fi

# Backup System Files
if [[ "$1" == "backup" && -n "$2" ]]; then
    echo "Backing up files from $2..."
    rsync -av --progress "$2" "$HOME/backup/"
    echo "Backup completed."
    exit 0
fi
