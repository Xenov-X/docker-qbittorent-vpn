#!/bin/bash
/usr/share/openrc/support/openvpn/up.sh

#/etc/transmission/start.sh "$@"

/qbittorrent/qbittorent-lockinterface-interface.sh "$@"
/qbittorrent/qbittorent-lockinterface-IP.sh "$@"


until ifconfig | grep tun | grep -q "00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00"; do
    sleep 0.5
done
# $1 is tun0 
# $3 is VPN IP interface 
/etc/openvpn/DNS-Leak-Test.sh
echo "starting qbitorrent"
qbittorrent-nox -d --webui-port=8080 --profile=/config --save-path=/downloads
echo "qbittorrent laucnched on localhost:8080"
[[ ! -f /opt/tinyproxy/start.sh ]] || /opt/tinyproxy/start.sh
