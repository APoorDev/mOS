#!/bin/sh

BLUEFIN_FETCH_LOGO="$(/usr/bin/find /usr/share/ublue-os/bluefin-logos/symbols/* | /usr/bin/shuf -n 1 )"

alias fastfetch="/usr/bin/fastfetch --file /usr/share/ublue-os/sd-logo.txt --logo-type file -c /usr/share/ublue-os/ublue-os.jsonc"
