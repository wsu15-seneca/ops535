# OPS535 Lab 4 Investigation 1: Algorithm for setup and configure an Primary DNS server with Dynamic Zone
# Written by: Eliza Su
# Last Modified Jun 20, 2021
# Run script on VM1 (router) and remote VM2 (pri-dns)
# Subject: DNS server recovery
# Based on the steps you performed on Lab 4 - Dynamic DNS lab, design and create an appropriate algorithm to setup and configure 
# a Primary DNS server with Dynamic zone on your Seneca VM2 remotely from the control VM (Seneca VM1). 
# Prepred files: named.conf, my-zone.txt, rev-zone.txt

echo
echo "Step 1 Unistall bind and bind-utils"
sudo yum remove bind bind-utils -y
echo

echo "Step 2 Stop and disable the DNS service (named)"
systemctl stop named
systemctl disable named
systemctl is-active named
echo

echo "Step 8 Use nslook or dig to check the DNS name server."
dig @192.168.26.2 pri-dns.wsu15.ops
echo

Step 9  Check firewall or iptables allow DNS service
firewall-cmd --add-service=dns --permanent --zone=internal
firewall-cmd --reload
firewall-cmd --list-all --zone=internal
echo

echo "Step 10 Save the script to ~student/ops535/lab4/scripts/lab4-ddns-setup.bash"
cp /home/student/ops535/lab3/lab4-ddns-setup.bash ~student/ops535/lab4/scripts/lab4-ddns-setup.bash
echo "ls ~student/ops535/lab4/scripts/"
ls ~student/ops535/lab4/scripts/
echo