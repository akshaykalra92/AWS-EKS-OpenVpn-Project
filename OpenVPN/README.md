# OpenVPN server and client setup using Ansible

This is an Ansible project which is used to set up OpenVPN server on ubuntu instance. 
This project has two ansible roles:

1. openVPNServer role: To create OpenVPN server setup
2. openVPNClient role: To create OpenVPN client ovpn file


You can change variables for openVPNClient role so you can create ovpn files with different users.

playbook.yml is main ansible file which is executed by ansible command.

Ansible command: **ansible-playbook playbook.yml**

