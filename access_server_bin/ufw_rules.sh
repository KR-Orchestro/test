#!/bin/sh
# The usage
# ufw_rules.sh <vpn ip range> <rule file>
#e.g.
# sudo su - ubuntu
# ./ufw_rules.sh "10.10.0.0/16" "/etc/ufw/before.rules"

#get out-interface with default route
OutIntf=$(ip route list default | awk '{print $5'})
echo $OutIntf

ReplaceStr='-A POSTROUTING -s '$1' -o '$OutIntf' -j MASQUERADE'
echo $ReplaceStr

#replace with NAT rule.
sudo sed -i "/\-A POSTROUTING \-s/c $ReplaceStr" $2

#then disable/enable ufw to take into effect
sudo ufw disable && sudo ufw enable

