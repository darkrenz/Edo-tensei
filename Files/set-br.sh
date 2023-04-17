#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
Myrepo="https://raw.githubusercontent.com/darkrenz/Edo-tensei/main/Files"
date
echo ""
sleep 1
echo -e "[ ${green}INFO${NC} ] Checking... "
sleep 2
sleep 1
echo -e "[ ${green}INFO${NC} ] Download & Install rclone... "
curl -fsSL https://rclone.org/install.sh | bash > /dev/null 2>&1
printf "q\n" | rclone config > /dev/null 2>&1
sleep 1
echo -e "[ ${green}INFO${NC} ] Downloading rclone config ... "
wget -q -O /root/.config/rclone/rclone.conf "$Myrepo"/rclone.conf
git clone https://github.com/magnific0/wondershaper.git &> /dev/null
cd wondershaper
sleep 1
echo -e "[ ${green}INFO${NC} ] Installing wondershaper... "
make install > /dev/null 2>&1
cd
rm -rf wondershaper > /dev/null 2>&1
echo > /home/limit

pkgs='msmtp-mta ca-certificates bsd-mailx'
if ! dpkg -s $pkgs > /dev/null 2>&1; then
sleep 1
echo -e "[ ${green}INFO${NC} ] Installing... "
apt install -y $pkgs > /dev/null 2>&1
else
sleep 1
echo -e "[ ${green}INFO${NC} ] Already Installed... "
fi
sleep 1
echo -e "[ ${green}INFO${NC} ] Creating service... "

cat> /etc/msmtprc << EOF
account default
host smtp.gmail.com
port 587
from 3bulanmm@gmail.com
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
auth on
user 3bulanmm
password aww123321aww
logfile ~/.msmtp.log
EOF

chown -R www-data:www-data /etc/msmtprc
sleep 1
echo -e "[ ${green}INFO${NC} ] Downloading files... "
wget -q -O /usr/bin/backup "$Myrepo"/backup.sh && chmod +x /usr/bin/backup
wget -q -O /usr/bin/restore "$Myrepo"/restore.sh && chmod +x /usr/bin/restore
wget -q -O /usr/bin/cleaner "$Myrepo"/logcleaner.sh && chmod +x /usr/bin/cleaner

if [ ! -f "/etc/cron.d/cleaner" ]; then
cat> /etc/cron.d/cleaner << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
* */6 * * * root /usr/bin/cleaner
END
fi

service cron restart > /dev/null 2>&1

rm -f /root/set-br.sh
