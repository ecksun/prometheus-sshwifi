#!/bin/bash

get_mac() {
    local ip="$1"
    awk '$2 == "'"$ip"'" { print $3 }' /var/lib/promscan/all
}

for i in "$1"/*; do
	ssid=$(awk '/SSID/ { print $2 }' < "$i")
	bssid=$(awk '/Connected to/ { print $3 }' < "$i")
	freq=$(awk '/freq/ { print $2 }' < "$i")
	strength=$(awk '/signal/ { print $2 }' < "$i")
	filename="$(basename "$i")"
	if [ -z "$ssid" ] || [ -z "$strength" ]; then
		continue
	fi
	ip="${filename%.log}"
	ip="${ip#iw_wlan0_link.}"
	mac=$(get_mac "$ip")
	printf 'associated_ap{mac="%s",ssid="%s",bssid="%s",freq="%s"} %s\n' "$mac" "$ssid" "$bssid" "$freq" "$strength"
done
