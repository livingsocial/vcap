# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  case ENV['BOX']
  when /base|ubuntu/
    config.vm.box = ENV['BOX']

    config.vm.provision :shell, :inline => \
      "apt-get -y install git-core && (gem list rake | grep rake > /dev/null) || gem install rake --no-rdoc --no-ri"
  else
    config.vm.box = "centos-6.2"

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "dev_setup/cookbooks"
      chef.add_recipe "centos"
    end
  end

  config.vm.provision :shell do |shell|
    require 'yaml'
    deployment_yml_path = File.expand_path("../.deployment.yml", __FILE__)
    File.open(deployment_yml_path, "w") {|f| f << YAML::dump("cloudfoundry" => { "path" => "/vagrant" }) }
    at_exit { File.unlink(deployment_yml_path) }
    shell.inline = '/vagrant/dev_setup/lib/chefsolo_launch.rb -c /vagrant/.deployment.yml'
  end
end
