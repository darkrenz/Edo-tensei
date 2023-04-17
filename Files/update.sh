#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

###########-Repo##########
Myrepo="https://raw.githubusercontent.com/darkrenz/Edo-tensei/main/Files"
###########- COLOR CODE -##############
echo -e " [INFO] Downloading Update File"
sleep 2
wget -q -O /usr/bin/menu "$Myrepo"/menu.sh && chmod +x /usr/bin/menu
wget -q -O /usr/bin/menu-ss "$Myrepo"/menu-ss.sh && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/menu-vmess "$Myrepo"/menu-vmess.sh && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/menu-vless "$Myrepo"/menu-vless.sh && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/menu-trojan "$Myrepo"/menu-trojan.sh && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/menu-bot "$Myrepo"/menu-bot.sh && chmod +x /usr/bin/menu-bot
wget -q -O /usr/bin/menu-ssh "$Myrepo"/menu-ssh.sh && chmod +x /usr/bin/menu-ssh
wget -q -O /usr/bin/menu-set "$Myrepo"/menu-set.sh && chmod +x /usr/bin/menu-set
wget -q -O /usr/bin/menu-theme "$Myrepo"/menu-theme.sh && chmod +x /usr/bin/menu-theme
wget -q -O /usr/bin/menu-backup "$Myrepo"/menu-backup.sh && chmod +x /usr/bin/menu-backup
wget -q -O /usr/bin/menu-ip "$Myrepo"/menu-ip.sh && chmod +x /usr/bin/menu-ip
wget -q -O /usr/bin/menu-tor "$Myrepo"/menu-tor.sh && chmod +x /usr/bin/menu-tor
wget -q -O /usr/bin/autoboot "$Myrepo"/autoboot.sh && chmod +x /usr/bin/autoboot
wget -q -O /usr/bin/menu-tcp "$Myrepo"/menu-tcp.sh && chmod +x /usr/bin/menu-tcp
wget -q -O /usr/bin/rebootvps "$Myrepo"/rebootvps.sh && chmod +x /usr/bin/rebootvps
wget -q -O /usr/bin/menu-dns "$Myrepo"/menu-dns.sh && chmod +x /usr/bin/menu-dns
wget -q -O /usr/bin/info "$Myrepo"/info.sh && chmod +x /usr/bin/info
wget -q -O /usr/bin/mspeed "$Myrepo"/menu-speedtest.sh && chmod +x /usr/bin/mspeed
wget -q -O /usr/bin/mbandwith "$Myrepo"/menu-bandwith.sh && chmod +x /usr/bin/mbandwith
echo -e " [INFO] Update Successfully"
sleep 2
exit
