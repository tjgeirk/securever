#!/bin/bash
# securver by TJGEIRK

dependencies{
  module_requirements=("unattended-updates" "ufw" "openvpn" "git" "python" "python3" "python3-pip");
repo_requirements=(“https://github.com/Nyr/openvpn-install/“ “https://github.com/skeeto/endlessh”);
} ; dependencies ;
sec_patch{
  passwd &&
  passwd root &&
  apt-get update &&
  apt-get upgrade -y &&
  apt-get autoremove -y;
};
  sec_patch &&
  
apt-get install $module_requirements;


git_repos{
  for repo in "${repo_requirements[@]}";
  do git clone $repo; 
  done;
};
  git_repos ;










