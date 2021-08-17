sudo brew services stop dnsmasq
brew uninstall caddy mkcert nss dnsmasq
sudo rm -rf /usr/local/Cellar/dnsmasq/2.85
sudo rm -rf '*.pem'
sudo rm -rf /etc/resolver
sudo rm -rf /usr/local/etc/dnsmasq.conf
sudo rm -rf /usr/local/etc/dnsmasq.conf.default
sudo rm -rf /usr/local/etc/dnsmasq.d
