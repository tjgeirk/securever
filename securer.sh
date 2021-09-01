#!/bin/bash
# securver by TJGEIRK

module_requirements=("unattended-updates" "ufw" "openvpn" "git" "python" "python3" "python3-pip")
repo_requirements=("https://github.com/Nyr/openvpn-install/" "https://github.com/skeeto/endlessh")

sec_patch{
  passwd &&
  passwd root &&
  apt-get update &&
  apt-get upgrade -y &&
  apt-get autoremove -y;
};

git_repos{
  for repo in "${repo_requirements[@]}";
  do git clone $repo; 
  done;
};
  apt-get install $module_requirements




