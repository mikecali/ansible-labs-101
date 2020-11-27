# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
  boxes = [
    {
      :name => "web1.demo.com",
      :box => "centos/8",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.29.2"
    },
    {
      :name => "web2.demo.com",
      :box => "centos/8",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.29.3"
    },
    {
      :name => "ansible-host",
      :box => "centos/8",
      :ram => 8048,
      :vcpu => 1,
      :ip => "192.168.29.4"
    }
  ]

  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
#   Only Enable this if you are connecting to Proxy server
#      config.proxy.http     = "http://usernam:password@x.y:80"
#      config.proxy.https    = "http://usernam:password@x.y:80"
#      config.proxy.no_proxy = "localhost,127.0.0.1"
      config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
      config.ssh.insert_key = false
      config.vm.box = opts[:box]
      config.vm.hostname = opts[:name]
      config.vm.provider :virtualbox do |v|
        v.memory = opts[:ram]
        v.cpus = opts[:vcpu]
      end
      config.vm.network :private_network, ip: opts[:ip]
      config.vm.provision :file do |file|
         file.source     = './keys/vagrant'
         file.destination    = '/tmp/vagrant'
        end
      config.vm.provision :file do |file|
        file.source     = './inventory-test.yaml'
        file.destination    = '/home/vagrant/inventory-test.yaml'
       end
      config.vm.provision :shell, path: "bootstrap-node.sh"
      config.vm.provision :ansible do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "playbook.yml"
      end
   end
  end
end
