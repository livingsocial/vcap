#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2011, VMware
#
#

case node['platform']
when "ubuntu"
  package 'python-software-properties'
  package 'default-jdk'
when "centos"
  package 'java-1.6.0-openjdk'
else
  Chef::Log.error("Installation of Sun Java packages not supported on this platform.")
end
