#!/usr/bin/env bash
# OPS535 Assigment 1 NFS setup
# Written by: Eliza Su
# Last Modified Jun 21, 2021
# Run script from VM1 (router) to VM3(co-nfs)
# Subject: NFS setup
# Prepred files: exports


echo "# step 1: move the network interface ens224 from firewalld's public zone to ineternal zone"
firewall-cmd --permanent --remove-interface=ens224 --zone=public
firewall-cmd --permanent --add-interface=ens224 --zone=internal
firewall-cmd --reload
firewall-cmd --list-all
echo
firewall-cmd --list-all --zone=internal
echo

echo "# step 2 install the nfs-utils rpm package if it has not already been installed"
yum install -y nfs-utils
echo

echo "# step 3 create an nfs share directory named '/nethome' with mod '1777'"
mkdir /nethome
chmod 1777 /nethome
echo "check /nethome should be drwxrwxrwx."
ls -al /

echo "# step 4 update the /etc/exports as required"
if [ -f /home/student/ops535/a1/exports ]
then
    cp /home/student/ops535/a1/exports /etc/exports
fi
echo "cat /etc/exports"
cat /etc/exports
echo

echo "# step 5 enable nfs-service srvice if has not already been enabled"
systemctl enable nfs-server 
echo

echo "# step 6 start nfs-server service if has not already been started"
systemctl start nfs-server
systemctl is-active nfs-server
echo
exportfs -a
showmount -e
echo

echo "# step 7 update firewallds's internal zone to allow nfs service"
firewall-cmd --permanent --add-service=nfs --zone=internal

# step 8 update firewalld's internal zone to allow nfs3 service service
firewall-cmd --permanent --add-service=nfs3 --zone=internal

# step 9 update firewalld's internal zone to allow rpc-bind service
firewall-cmd --permanent --add-service=rpc-bind --zone=internal
firewall-cmd --reload
firewall-cmd --list-all --zone=internal
echo

# step 10 save the script to ~student/ops535/a1/scripts/lab2-nfs-setup.bash
mkdir ops535
cd ops535
mkdir a1
cd a1
mkdir scripts
cp lab2-nfs-setup.bash ~student/ops535/a1/scripts/a1-nfs-setup.bash
ls ~student/ops535/a1/scripts/ -al
