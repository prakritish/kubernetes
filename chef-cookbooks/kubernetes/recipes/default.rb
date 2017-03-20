#
# Cookbook:: kubernetes
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
include_recipe "selinux::permissive"

package "ntp" do
  package_name "ntp"
  action :install
  notifies :restart, "service[ntp]"
end

service "ntp" do
  service_name "ntpd"
  action [:start, :enable]
end

package "docker-ce" do
  package_name "docker-ce"
  action :remove
end

ruby_block "update /etc/hosts to resolve the aliases" do
  block do
    fh = Chef::Util::FileEdit.new("/etc/hosts")
    node['hosts'].each do |name, ip|
      fh.search_file_replace_line(name, ip + " " + name)
      fh.insert_line_if_no_match(name, ip + " " + name)
    end
    fh.write_file
  end
end

file "/etc/yum.repos.d/docker-ce.repo" do
  action :delete
end

yum_repository "virt7-docker-common-release" do
  description "Docker Common Release"
  baseurl "http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/"
  gpgcheck false
  action :create
end

["kubernetes", "docker"].each do |pkg|
  package pkg do
    package_name pkg
    action :install
  end
end

ruby_block "update /etc/kubernetes/config file" do
  block do
    fh = Chef::Util::FileEdit.new("/etc/kubernetes/config")
    node['config'].each do |regex, line|
      fh.search_file_replace_line(regex, line)
      fh.insert_line_if_no_match(regex, line)
    end
    fh.write_file
  end
end

