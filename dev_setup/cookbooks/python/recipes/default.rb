#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2012, VMware
#
#

case node['platform']
when 'ubuntu'
  %w[ python-dev python-setuptools ].each do |pkg|
    package pkg
  end
when 'centos'
  %w[ python python-setuptools ].each do |pkg|
    package pkg
  end
end

bash "Installing pip" do
  code "sudo easy_install pip"
end
