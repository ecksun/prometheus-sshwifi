#!/bin/bash

state_dir="$1"
mkdir "$state_dir"

for i in $(awk '{ print $2 }' /var/lib/promscan/all); do
	timeout 10s sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false "root@$i" iw wlan0 link > "$state_dir/iw_wlan0_link.$i.log" 2>/dev/null &
done
wait
