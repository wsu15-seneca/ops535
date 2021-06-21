#!/usr/bin/env bash
# OPS535 Assigment Basic Setup
# Written by: Eliza Su
# Last Modified Jun 21, 2021
# Run script on VM1-4
# Subject: Basic setup
# Prepred files: etc-hosts-vm1.txt, ansible-hosts.txt


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