#!/bin/bash

read -p 'access point IP/hostname: ' host

read -p 'wifi SSID: ' ssid
read -p 'wifi PSK: ' psk
read -p 'ssh username: ' user

echo "setup SSH password"

# although defaulting to method 1 (md5) the aps do (appear) to support SHA256/512
passhash=$(openssl passwd -6)

sed -e "s;<<SSID>>;$ssid;g" -e "s;<<PSK>>;$psk;g" -e "s;<<USER>>;$user;g" -e "s;<<PASSHASH>>;$passhash;g" template.cfg > new.cfg


# don't know what this is for but probably should be randomised
authkey=$(</dev/urandom tr -dc 'A-Z' | fold -w32 | head -n1)

sed -e "s;<<AUTHKEY>>;$authkey;g" mgmt-template > mgmt

echo "default password is ubnt"

scp mgmt ubnt@$host:/etc/persistent/cfg/
scp new.cfg ubnt@$host:/tmp/
ssh ubnt@$host "cfgmtd -w -p /etc/ -f /tmp/new.cfg && reboot"
