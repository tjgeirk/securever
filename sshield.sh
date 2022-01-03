#!/bin/bash
#
# MODIFY THIS PORT BEFORE RUNNING
port=“NEW SSH PORT HERE”
module_requirements=("unattended-updates" "ufw" "ssh" "openssh-server" "sslh" "fail2ban" "python" "python3" "python3-pip" "docker.io");
repo_requirements=("https://github.com/Nyr/openvpn-install/" "https://github.com/Nyr/wireguard-install/" "https://github.com/skeeto/endlessh");
apt-get update
apt-get -y full-upgrade
for module in "${module_requirements[@]}"; do
    apt-get -y install $module
done
for repo in "${repo_requirements[@]}"; do 
    git clone $repo
done
echo "Port $port" >> /etc/ssh/sshd_config
ufw allow $port
systemctl daemon-reload
systemctl restart ssh
service ssh start
ssh-keygen
make ./endlessh/endlessh
cp ./endlessh/endlessh /usr/bin/endlessh
cp ./endlessh/endlessh.service /etc/systemd/system/endlessh.service
mkdir /etc/endlessh
printf %b “Port 22/nPort 2222” > /etc/endlessh/config
systemctl enable endlessh
service endlessh start
service fail2ban start
ufw enable
