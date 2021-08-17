sudo brew services start dnsmasq

scutil --dns
# dnsmasq setup is successful if you see an entry for test domain like this:
# resolver #8
#   domain   : test
#   nameserver[0] : 127.0.0.1
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00030002 (Reachable,Local Address,Directly Reachable Address)

sudo caddy run --config Caddyfile