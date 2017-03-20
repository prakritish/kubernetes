#
# Cookbook:: kubernetes
# Recipe:: minion
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
ruby_block "update /etc/kubernetes/kubelet" do
  block do
    fh = Chef::Util::FileEdit.new("/etc/kubernetes/kubelet")
    node['kubelet'].each do |regex, line|
      fh.search_file_replace_line(regex, line)
      fh.insert_line_if_no_match(regex, line)
    end
    fh.write_file
  end
end

["kube-proxy", "kubelet", "docker"].each do |svc|
  service svc do
    service_name svc
    action :start
  end
end

docker_image 'busybox' do
  action :pull
end

docker_container 'echo_server' do
  repo 'busybox'
  port '1234:1234'
  command "nc -ll -p 1234 -e /bin/cat"
end

docker_container 'echo_server' do
  kill_after 30
  action [:stop, :delete]
end
