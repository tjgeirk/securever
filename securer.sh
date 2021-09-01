#!/bin/bash
# securver by TJGEIRK
sec_patch{
    passwd && passwd root &&
    apt-get update && apt-get upgrade -y && apt-get autoremove -y;
};
assign_values(){
    module_requirements=("unattended-updates" "ufw" "sslh" "git" "python" "python3" "python3-pip" 
        "docker-ce" "openvpn" "wireguard-tools" "shadowsocks-libev");
    repo_requirements=("https://github.com/Nyr/openvpn-install/" "https://github.com/Nyr/wireguard-install/" 
        "https://github.com/skeeto/endlessh" );
};
git_repos(){
    for repo in "${repo_requirements[@]}";
    do git clone $repo; 
    done;
};
access(){
    echo "Port 4847" >> /etc/ssh/sshd_config;
    echo "port 4847" >> /etc/ssh/ssh_config;
    systemctl enable ssh;
    service ssh start;
    ssh-keygen;
};
set +x;
sec_patch && assign_values;
apt-get install $module_requirements && 
git_repos &&
access;
