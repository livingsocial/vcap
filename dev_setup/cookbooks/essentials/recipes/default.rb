#
# Cookbook Name:: essentials
# Recipe:: default
#
# Copyright 2011, VMWARE
#
#

packages = \
case node['platform']
when "ubuntu"
  %w{apt-utils build-essential libssl-dev
   libxml2 libxml2-dev libxslt1.1 libxslt1-dev git-core sqlite3 libsqlite3-ruby
   libsqlite3-dev unzip zip ruby-dev libmysql-ruby libmysqlclient-dev libcurl4-openssl-dev libpq-dev}
when "centos"
  %w{unzip zip mysql mysql-devel postgresql postgresql-devel}
else
  []
end

packages.each do |p|
  package p do
    action [:install]
  end
end

if node[:deployment][:profile]
  file node[:deployment][:profile] do
    owner node[:deployment][:user]
    group node[:deployment][:group]
    content "export PATH=#{node[:ruby][:path]}/bin:`#{node[:ruby][:path]}/bin/gem env gempath`/bin:$PATH"
  end
end
