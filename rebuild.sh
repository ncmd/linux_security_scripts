#!/bin/bash
FILE="./urls.txt"
DNSSERVER="172.16.0.5"
UNBOUND_LIST="./unbound.whitelist"
SQUID_LIST="./etc/host.whitelist"
# Build a list of urls in SQUID and Unbound foramt
# from a list or urls, one line per domain.

function rebuild(){
	echo "" > "$UNBOUND_LIST"
	echo "" > "$SQUID_LIST"
	awk '!($1 in a) { a[$1]; print }' "$FILE" | sed -e "s/www.//g" | sort | uniq | while read LINE; do
		add_unbound "$LINE"
		add_squid "$LINE"
	done
}

function add_unbound(){
	local DOMAIN
	DOMAIN="$1"
	echo "Adding $DOMAIN to Unbound!"
	echo -e "forward-zone:\n\tname: $DOMAIN\n\tforward-addr: $DNSSERVER\n" >> "$UNBOUND_LIST"
}
function add_squid(){
	local DOMAIN
	DOMAIN="$1"
	echo "Adding $DOMAIN to SQUID!"
	echo ".$DOMAIN" >> "$SQUID_LIST"
}

rebuild
