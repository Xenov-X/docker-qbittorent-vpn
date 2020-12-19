#!/bin/bash
# run with $@ arg from openvpn
echo "$@"
Interface="$1"

QBT_CONFIG_FILE="/config/qBittorrent/config/qBittorrent.conf"

if [ -f "$QBT_CONFIG_FILE" ]; then
    # if Connection address line exists
    if grep -q 'Connection\\PortRangeMin' "$QBT_CONFIG_FILE"; then
        # Set connection interface address to the VPN address
        sed -i -E 's/^.*\b(Connection.*Interface=)\b.*$/Connection\\InterfaceAddress='"$Interface"'/' "$QBT_CONFIG_FILE"
    else
        # add the line for configuring interface address to the qBittorrent config file
        printf 'Connection\\Interface=%s' "$Interface" >>"$QBT_CONFIG_FILE"
    fi
else
    # Ensure config directory is created
    mkdir -p "$(dirname "$QBT_CONFIG_FILE")"
    # Create the configuration file from a template and environment variables
    printf '[Preferences]\nConnection\\Interface=%s\n' "$Interface" >"$QBT_CONFIG_FILE"
fi
