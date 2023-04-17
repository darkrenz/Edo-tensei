#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

Myrepo="https://raw.githubusercontent.com/darkrenz/Edo-tensei/main/Files"

BURIQ () {
    curl -sS https://raw.githubusercontent.com/darkrenz/noteX/main/IP-Verifybypasstanginaka > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}
# https://raw.githubusercontent.com/darkrenz/noteX/main/IP-Verifybypasstanginaka 
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/darkrenz/noteX/main/IP-Verifybypasstanginaka | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="IP-Register Accepted..."
fi
}

IP-Register () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/darkrenz/noteX/main/IP-Verifybypasstanginaka | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="IP-Register Denied!"
    fi
    BURIQ
}

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 2
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 1
totet=`uname -r`
REQUIRED_PKG="linux-headers-$totet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  sleep 2
  echo -e "[ ${yell}WARNING${NC} ] Try to install ...."
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  apt-get --yes install $REQUIRED_PKG
  sleep 1
  echo ""
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] If error you need.. to do this"
  sleep 1
  echo ""
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 1. apt update -y"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 2. apt upgrade -y"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 3. apt dist-upgrade -y"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 4. reboot"
  sleep 1
  echo ""
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] After rebooting"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] Then run this script again"
  echo -e "[ ${tyblue}NOTES${NC} ] AutoScript"
  echo -e "[ ${tyblue}NOTES${NC} ] Tap Enter"
  read
else
  echo -e "[ ${green}INFO${NC} ] okay installed"
fi

ttet=`uname -r`
ReqPKG="linux-headers-$ttet"
if ! dpkg -s $ReqPKG  >/dev/null 2>&1; then
  rm /root/setup.sh >/dev/null 2>&1 
  exit
else
  clear
fi


secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Philippines /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

coreselect=''
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
END
chmod 644 /root/.profile

echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Allright good ... installation file is ready"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check IP-Register : "

IP-Register
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "IP-Register Accepted..." ]; then
green "IP-Register Accepted!"
else
red "IP-Register Denied!"
rm setup.sh > /dev/null 2>&1
sleep 10
exit 0
fi
sleep 3

mkdir -p /etc/ssnvpn
mkdir -p /etc/ssnvpn/theme
mkdir -p /var/lib/ssnvpn-pro >/dev/null 2>&1
echo "IP=" >> /var/lib/ssnvpn-pro/ipvps.conf

if [ -f "/etc/xray/domain" ]; then
echo ""
echo -e "[ ${green}INFO${NC} ] Script Already Installed"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to install again ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm setup.sh
sleep 10
exit 0
else
clear
fi
fi

echo ""
wget -q "$Myrepo"/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear

yellow "Add Domain: (tap enter to ignore)"
echo -e "┌─────────────────────────────────────────────────┐"
echo -e "│           • Autoscript by Notedeob •            │"
echo -e "└─────────────────────────────────────────────────┘"
echo -e ""
read -rp "        Input your domain : " -e pp
echo "$pp" > /root/domain
echo "$pp" > /root/scdomain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/xray/scdomain
echo "IP=$pp" > /var/lib/ssnvpn-pro/ipvps.conf

#THEME RED
cat <<EOF>> /etc/ssnvpn/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
#THEME BLUE
cat <<EOF>> /etc/ssnvpn/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
#THEME GREEN
cat <<EOF>> /etc/ssnvpn/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
#THEME YELLOW
cat <<EOF>> /etc/ssnvpn/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME MAGENTA
cat <<EOF>> /etc/ssnvpn/theme/magenta
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME CYAN
cat <<EOF>> /etc/ssnvpn/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
#THEME CONFIG
cat <<EOF>> /etc/ssnvpn/theme/color.conf
blue
EOF
    
#install ssh ovpn
echo -e "$green[INFO]$NC Install SSH"
sleep 2
clear
wget "$Myrepo"/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#Instal Xray
echo -e "$green[INFO]$NC Install XRAY!"
sleep 2
clear
wget "$Myrepo"/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
wget "$Myrepo"/set-br.sh && chmod +x set-br.sh && ./set-br.sh
clear
wget "$Myrepo"/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
wget "$Myrepo"/nontls.sh && chmod +x nontls.sh && ./nontls.sh
clear
echo -e "$green[INFO]$NC Download Extra Menu"
sleep 2
wget "$Myrepo"/update.sh && chmod +x update.sh && ./update.sh
clear
ln -fs /usr/share/zoneinfo/Asia/Philippines /etc/localtime
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS "$Myrepo"/version  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps

echo -e "\033[1;31m#########################################################################\033[0m" | tee -a log-install.txt
echo -e "\033[1;31m#                      Autoscript by Notedeob                           #\033[0m" | tee -a log-install.txt
echo -e "\033[1;31m#########################################################################\033[0m" | tee -a log-install.txt
echo ""
echo -e "\e[1;32m┌─────────────────────────────────────────────────┐\e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│           Service             | Port              \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m├─────────────────────────────────────────────────┤\e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   OpenSSH                     | 22                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   SSH Websocket               | 80       [OFF]    \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   SSH SSL Websocket           | 443               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   SSH NON-SSL Websocket       | 8880              \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Stunnel4                    | 447, 777          \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Dropbear                    | 109, 143          \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Badvpn                      | 7100-7900         \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Nginx                       | 81                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   XRAY Vmess TLS              | 443               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   XRAY Vmess None TLS         | 80                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   XRAY Vless TLS              | 443               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   XRAY Vless None TLS         | 80                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Trojan GRPC                 | 443               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Trojan WS                   | 443               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Sodosok WS/GRPC             | 443               \e[0m"| tee -a log-install.txt
echo -e "\e[1;32m├─────────────────────────────────────────────────┤\e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│           Service             | Details              \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m├─────────────────────────────────────────────────┤\e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   >>> Server Information & Other Features                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Timezone                   | Asia/Philippines (GMT +7)    \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Fail2Ban                   | [ON]               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Dflate                     | [ON]              \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   IPtables                   | [ON]          \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Auto-Reboot               | [ON]          \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   IPv6                       | [OFF]         \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Autoreboot On               | $aureb:00 $gg GMT +7                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Autobackup Data               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   AutoKill Multi Login User                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Auto Delete Expired Account               \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Fully automatic script                \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   VPS settings                             \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Admin Control                              \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m│   Restore Data                        \e[0m" | tee -a log-install.txt
echo -e "\e[1;32m├─────────────────────────────────────────────────┤\e[0m" | tee -a log-install.txt
echo ""
echo "" | tee -a log-install.txt
rm /root/cf.sh >/dev/null 2>&1
rm /root/setup.sh >/dev/null 2>&1
rm /root/insshws.sh 
rm /root/update.sh
rm /root/nontls.sh
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "
"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
