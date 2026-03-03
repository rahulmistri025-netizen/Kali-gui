#!/bin/bash

# Start VNC server
su - kali -c "vncserver :1 -geometry 1280x800 -depth 24"

# Start noVNC
websockify --web=/usr/share/novnc/ 8080 localhost:5901 &
exec supervisord -n
