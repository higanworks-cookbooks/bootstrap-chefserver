#
# Cookbook Name:: bootstrap-chefserver
# Recipe:: default
#
# Copyright 2012, HiganWorks LLC
#
# All rights reserved
#
#
include_recipe "apt"

apt_repository "opscode" do
  uri "http://apt.opscode.com"
  distribution [node.lsb.codename, "-0.10"].join
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "83EF826A"
end

# cookbook apt has bug ?
# apt-get update notifies does not work.
# here is work around.
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :run
end

file "/etc/apt/sources.list.d/opscode.update-once.list" do
  action :create_if_missing
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

%w(ohai chef chef-server).each do |w|
  package w do
    action :install
  end
end
