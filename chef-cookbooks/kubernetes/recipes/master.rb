#
# Cookbook:: kubernetes
# Recipe:: master
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
package "bash-completion" do
  package_name "bash-completion"
  action :install
end

ruby_block "update .bash_profile and .bashrc" do
  block do
    fh = Chef::Util::FileEdit.new("/root/.bash_profile")
    fh.insert_line_if_no_match(/.bashrc/, "source ~/.bashrc")
    fh.write_file
    fh1 = Chef::Util::FileEdit.new("/root/.bashrc")
    fh1.insert_line_if_no_match(/kubectl completion/, "source <(kubectl completion bash)")
    fh1.write_file
  end
end

["etcd", "kube-apiserver", "kube-controller-manager", "kube-scheduler"].each do |svc|
  service svc do
    action :start
  end
end
