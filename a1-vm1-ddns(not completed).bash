#!/usr/bin/env bash
# OPS535 Assigment 1 DNS setup
# Written by: Eliza Su
# Last Modified Jun 21, 2021
# Run script from VM1 (router) to VM2(pri-dns), VM3(co-nfs) and VM4(rns-ldap)
# Subject: DNS server, caching, and RNS setup
# Prepred files: 

echo
echo "# step 1: move the network interface ens224 from firewalld's public zone to ineternal zone"
firewall-cmd --permanent --remove-interface=ens224 --zone=public
firewall-cmd --permanent --add-interface=ens224 --zone=internal
firewall-cmd --reload
firewall-cmd --list-all --zone=internal
echo


















echo
echo "Step 1 Copy the hosts file on Vm1"
cp /home/student/ops535/a1/etc-hosts-vm1.txt /etc/hosts
echo "cat /etc/hosts"
cat /etc/hosts
echo

echo
echo "Step 2 copy the key to Vms, depends on which VM is broken"
ssh-copy-id -i ~/.ssh/id_rsa.pub student@pri-dns
echo


echo
echo "Step 3 Copy the ansible hosts file on Vm1"
cp /home/student/ops535/a1/ansible-hosts /etc/ansible/hosts
echo "cat /etc/ansible/hosts"
cat /etc/ansible/hosts
echo

echo
echo "Step 4 gather useful variables about remote hosts that can be used in ansible playbooks"
ansible pri-dns.wsu15.ops -m setup > pri-dns-setup.txt
ansible co-nfs.wsu15.ops -m setup > co-nfs-setup.txt
ansible rns-ldap.wsu15.ops -m setup > rns-ldap-setup.txt
echo