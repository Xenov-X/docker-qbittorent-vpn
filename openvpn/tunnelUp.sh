#!/bin/bash
/usr/share/openrc/support/openvpn/up.sh
/etc/transmission/start.sh "$@"

until ifconfig | grep tun | grep -q "00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00"; do
    sleep 0.5
done
# $1 is tun0 
# $3 is VPN IP interface 
/etc/openvpn/DNS-Leak-Test.sh

set
qbittorrent-nox -d 
[[ ! -f /opt/tinyproxy/start.sh ]] || /opt/tinyproxy/start.sh
