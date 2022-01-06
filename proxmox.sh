#!/bin/bash

#change ssh port and rootLogin
sed -i 's/#Port\ 22/Port\ 2212/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin\ yes/PermitRootLogin\ without-password/g' /etc/ssh/sshd_config
systemctl restart sshd

# Update and install essential packages 
apt update
apt upgrade -y
apt install -y ifupdown2 openvswitch-switch fail2ban




