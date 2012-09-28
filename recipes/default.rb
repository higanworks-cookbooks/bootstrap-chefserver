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

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)


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

apmq_password = secure_password

script "configure dpkgs" do
  interpreter "bash"
  code <<-EOH
cat <<EOF | debconf-set-selections
chef chef/chef_server_url string http://#{node.ipaddress}:4000
chef-solr chef-solr/amqp_password password #{apmq_password}
chef-server-webui chef-server-webui/admin_password password p@ssword
EOF

EOH
  not_if { File.exist?("/etc/apt/sources.list.d/opscode.update-once.list") }
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


%w(chef-server chef-server-webui chef-solr).each do |w|
  service w
end
