
# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<-EOL
# vagrant environment nodes
192.168.29.2  Web1.demo.com
192.168.29.3  Web2.demo.com
192.168.29.4  ansible-host
