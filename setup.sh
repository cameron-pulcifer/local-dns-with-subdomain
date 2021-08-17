brew install caddy mkcert nss dnsmasq

# set up dnsmasq with a ".test" top-level-domain extension
# requires a domain, e.g., http://<anything>.test
cat <<EOF >> /usr/local/etc/dnsmasq.conf
address=/.test/.xyz/127.0.0.1
port=53
no-resolv
domain-needed
bogus-priv
EOF

sudo mkdir /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/xyz'
mkcert '*.developer.test'
mkcert '*.developer.xyz'
