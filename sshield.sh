#!/bin/bash
port=41917
apt-get update
apt-get -y full-upgrade
apt-get -y install unattended-updates ufw sslh fail2ban curl git cmake make
ssh-keygen
ufw allow $port
ufw allow 443
ufw allow 80
if [ -d /etc/crowdsec ]; then
    echo "crowdsec already installed"
else
    curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
    apt-get install crowdsec
fi
if [ -d /etc/endlessh ]; then
    echo "endlessh already installed"
else
    git clone https://github.com/skeeto/endlessh /etc/endlessh
    echo "Port 22" > /etc/endlessh/config
    make /etc/endlessh/endlessh
    cp /etc/endlessh/endlessh /usr/bin/endlessh
    cp /etc/endlessh/endlessh /bin/endlessh
    cp /etc/endlessh/endlessh /sbin/endlessh
    cp /etc/endlessh/endlessh.service /etc/systemd/system/endlessh.service
fi
systemctl enable endless
systemctl enable fail2ban
systemctl enable crowdsec
ufw enable
