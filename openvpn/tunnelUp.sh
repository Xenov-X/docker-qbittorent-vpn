#!/bin/bash
/usr/share/openrc/support/openvpn/up.sh
/etc/transmission/start.sh "$@"

until ifconfig | grep tun | grep -q "00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00"; do
    sleep 0.5
done

/etc/openvpn/DNS-Leak-Test.sh

qbittorrent-nox -d
[[ ! -f /opt/tinyproxy/start.sh ]] || /opt/tinyproxy/start.sh
