#!/bin/bash
# Proxy For WS
# ==========================================
# Color

Myrepo="https://raw.githubusercontent.com/darkrenz/Edo-tensei/main/Files"

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
NC='\e[0m'
echo "Installing SSH Websocket by NoteDeobfuscate" | lolcat
echo "Progress..." | lolcat
sleep 3
cd

#Install Script Websocket-SSH Python
wget -O /usr/local/bin/ws-dropbear "$Myrepo"/ws-dropbear
wget -O /usr/local/bin/ws-stunnel "$Myrepo"/ws-stunnel

#izin permision
chmod +x /usr/local/bin/ws-dropbear
chmod +x /usr/local/bin/ws-stunnel

#System Dropbear Websocket-SSH Python
wget -O /etc/systemd/system/ws-dropbear.service "$Myrepo"/ws-dropbear.service && chmod +x /etc/systemd/system/ws-dropbear.service

#System SSL/TLS Websocket-SSH Python
wget -O /etc/systemd/system/ws-stunnel.service "$Myrepo"/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service


#restart service
systemctl daemon-reload

#Enable & Start & Restart ws-dropbear service
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

#Enable & Start & Restart ws-openssh service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service
