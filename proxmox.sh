#!/bin/bash

# Add a sudo user with ssh key
adduser youser -gecos "" --disabled-password
echo "youser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
usermod -aG sudo youser
mkdir /home/youser/.ssh
echo "VOTRE_CLE_SSH_PUBLIQUE" > /home/youser/.ssh/authorized_keys


#change ssh port and rootLogin
sed -i 's/Port\ 22/Port\ 2212/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin\ yes/PermitRootLogin\ without-password/g' /etc/ssh/sshd_config
service ssh restart

# Update and install essential packages
apt update
apt upgrade -y
apt install -y ifupdown2 openvswitch-switch fail2ban

#PVE user management
pveum groupadd admin -comment "System Administrators"
pveum aclmod / -group admin -role Administrator
pveum useradd youser@pam -comment "Admin user"
pveum usermod youser@pam -group admin



