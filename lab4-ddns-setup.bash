# OPS535 Lab 4 Investigation 1: Algorithm for setup and configure an Primary DNS server with Dynamic Zone
# Written by: Eliza Su
# Last Modified Jun 20, 2021
# Run script on VM1 (router) and remote VM2 (pri-dns)
# Subject: DNS server setup
# Based on the steps you performed on Lab 4 - Dynamic DNS lab, design and create an appropriate algorithm to setup and configure 
# a Primary DNS server with Dynamic zone on your Seneca VM2 remotely from the control VM (Seneca VM1). 
# Prepred files: named.conf, my-zone.txt, rev-zone.txt

echo
echo "Step 1 Install bind and bind-utils"
sudo yum install bind bind-utils -y
echo

echo "Step 2 Copy named.conf to /etc/named.conf, use named-checkconf check the file."
cp /home/student/ops535/lab4/named.conf /etc/named.conf
named-checkconf /etc/named.conf
echo
echo "cat /etc/named.conf"
cat /etc/named.conf 
echo

echo "Step 3 Copy my-zone.txt to /var/named/my-zone.txt as forward zone, the user and group ownership should be set to named. The user account for named must be able to write to both files. Use named-checkzone to check the file."
cp /home/student/ops535/lab4/my-zone.txt /var/named/my-zone.txt
chgrp my-zone.txt /var/named/my-zone.txt
chmod u=rwx /var/named/my-zone.txt
ls -al /var/named/
echo 
named-checkzone /var/named/my-zone.txt
echo
echo "cat /var/named/my-zone.txt"
cat /var/named/my-zone.txt
echo

echo "Step 4 Copy rev-zone.txt to /var/named/rev-zone.txt as reverse zone, the user and group ownership should be set to named. The user account for named must be able to write to both files. Use named-checkzone to check the file."
cp /home/student/ops535/lab4/my-zone.txt /var/named/my-zone.txt
chgrp rev-zone.txt /var/named/rev-zone.txt
chmod u=rwx /var/named/rev-zone.txt
ls -al /var/named/
echo 
named-checkzone /var/named/my-zone.txt
echo
echo "cat /var/named/rev-zone.txt"
cat /var/named/rev-zone.txt
echo

echo "Step 5 Check the SELinux context type for both zone files should be “named_zone_t”. "
ls -Z my-zone.txt
ls -Z rev-zone.txt
echo

echo "Step 6 Check the SELinux boolean that allows named to write to the /var/named directory (named_write_master_zones) must be set to on."
getsebool -a | grep named_write_master_zones
echo

echo "Step 7 Start the DNS service (named), and ensure that it will automatically start when the machine boots."
systemctl start named
systemctl enable named
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