# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos-6.2"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "dev_setup/cookbooks"
    chef.add_recipe "centos"
  end

  config.vm.provision :shell do |shell|
    require 'yaml'
    File.open(".deployment.yml", "w") {|f| f << YAML::dump("cloudfoundry" => { "path" => "/vagrant" }) }
    at_exit { File.unlink(".deployment.yml") }
    shell.inline = '/vagrant/dev_setup/lib/chefsolo_launch.rb -c /vagrant/.deployment.yml'
  end
end
