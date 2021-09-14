#!/bin/bash
# securver by TJGEIRK

# MODIFY THIS PORT BEFORE RUNNING
port=“NEW SSH PORT HERE”

assign_values(){
    module_requirements=("unattended-updates" "ufw" "sslh" "git" "python" "python3" "python3-pip" "docker-ce" "openvpn" "wireguard-tools" "shadowsocks-libev");
    repo_requirements=("https://github.com/Nyr/openvpn-install/" "https://github.com/Nyr/wireguard-install/" "https://github.com/skeeto/endlessh");
}; set +x;  assign_values;
sec_patch(){
    apt-get update &&
    apt-get full-upgrade -y;
}; sec_patch;
git_repos(){
    for repo in "${repo_requirements[@]}";
    do git clone $repo; 
    done;
};git_repos;
access(){
    echo "Port $port" >> /etc/ssh/sshd_config;
    echo "port $port" >> /etc/ssh/ssh_config;
    ufw allow $port && ufw enable;
    systemctl daemon-reload;
    systemctl restart ssh;
    service ssh start;
    ssh-keygen;
}; access; 
endlessh_make(){
    make ./endlessh &&
    mv endlessh/endlessh /bin/endlessh;
    mv endlessh/endlessh.service /etc/systemd/system/endlessh.service;
    mkdir /etc/endlessh &&
    printf %b “Port 22/nPort 2222” > /etc/endlessh/config &&
    systemctl enable endlessh &&
    service endlessh start;
}; endlessh_make;
