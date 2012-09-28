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
  distribution node.lsb.codename
  components ["universe"]
  keyserver "keyserver.ubuntu.com"
  key "83EF826A"
end

%w(ohai chef).each do |w|
  package w do
    action :install
  end
end
