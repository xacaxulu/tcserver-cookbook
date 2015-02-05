#
# Cookbook Name:: tcserver-cookbook
# Recipe:: java-for-tcserver

    
if node[:kernel][:machine] == 'x86_64' && node[:kernel][:name].downcase == 'linux'
  basename = node['tcserver']['java']['jdk_64'].gsub('.tar.gz','')

  ["/tmp/#{basename}","/opt/vFabric/java"].each do |dir|
    directory dir do
      owner 'root'
      group 'root'
      mode '755'
      action :create
      recursive true
      not_if { ::Dir.exists?(dir)}
    end
  end

  remote_file "/opt/vFabric/java/#{node['tcserver']['java']['jdk_64']}" do
    owner 'root'
    group 'root'
    mode '0644'
    source node['tcserver']['java']['jdk_url_64']
    notifies :run, 'bash[expand_file]', :immediately
    not_if { ::File.exists?("/opt/vFabric/java/#{node['tcserver']['java']['jdk_64']}")}
  end

  bash "expand_file" do
    cwd "/opt/vFabric/java"
    code <<-EOH
      tar xvf #{node[:tcserver][:java][:jdk_64]};
    EOH
    action :nothing
  end

  directory "/opt/vFabric/java/#{basename}/" do
    owner 'root'
    group 'root'
    mode '755'
    action :create
    recursive true
  end
  
end