#!/bin/bash

# Using sshpass or authorized_keys, usbmuxd and tcprelay for a better test performance.
scp "./LatestBuild.deb" root@localhost:"/var/root/LatestBuild.deb"
ssh root@localhost "dpkg -i /var/root/LatestBuild.deb; killall SpringBoard backboardd"
