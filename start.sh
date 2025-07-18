#!/bin/bash

# Set non-interactive for frontend
export DEBIAN_FRONTEND=noninteractive
echo "deb http://archive.ubuntu.com/ubuntu focal main universe" > /etc/apt/sources.list
dpkg --configure -a || true

# Install xfce4 and expect
apt-get update && apt-get install -y xfce4 expect

# Start RDP in background
task=$(xfreerdp /v:localhost:3389 /u:naeem123 /p:naeem@123 &)
echo "$!" > /tmp/rdp-task.pid

# Print RDP and keep-alive session lines
echo "RDP started"
echo "xfreerdp session display :1 @ $(date)"
task=$(xfreerdp-session display :1 @ $(date))

# Auto type to keep it alive
while true
do
    tmux send-keys -t AnyNameHere.net 'echo alive && date' C-m
    sleep 300
done
