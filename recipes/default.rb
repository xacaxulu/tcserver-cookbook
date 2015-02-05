#
# Cookbook Name:: tcserver-cookbook
# Recipe:: java-for-tcserver

basename = node[:tcserver][:tarball].gsub('.tar.gz','')

group 'tomcat' do; end

user 'tomcat' do
  group 'tomcat'
end

directory "/opt/vFabric" do
  owner 'root'
  group 'root'
  mode '775'
  action :create
end 
 
remote_file "/opt/vFabric/#{node[:tcserver][:tarball]}" do
  owner 'root'
  group 'root'
  mode '0644'
  source node[:tcserver][:tarball_url]
  notifies :run, 'bash[unzip_file]', :immediately
  not_if { ::File.exists?("/opt/vFabric#{node[:tcserver][:tarball]}")}
end
 
bash "unzip_file" do
  cwd "/opt/vFabric"
  code <<-EOH
    tar -zxf #{node[:tcserver][:tarball]}
  EOH
  action :nothing
end

data_bag('instances').each do |i|
  inst = data_bag_item('instances',i)

  tcserver_instance inst['id'] do
    tc_server_version inst['tc_server_version']
    java_home inst['JAVA_HOME']
    catalina_base "/#{inst['id']}"
    basename "#{basename}"
    port inst['port']
    not_if { Dir.exists? "/opt/vFabric/#{inst['id']}"}
  end 
  
  tcserver_ctl inst['id'] do
    java_home inst['JAVA_HOME']
    catalina_base "/#{inst['id']}"
    action :start
    not_if { File.exists? "/opt/vFabric/#{inst['id']}/logs/tcserver.pid" }
  end
end

