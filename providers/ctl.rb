use_inline_resources

action :start do

  execute "start_#{new_resource.instance_name}" do
    ENV['JAVA_HOME'] = new_resource.java_home
    ENV['CATALINA_BASE'] = new_resource.catalina_base
    user 'tomcat'
    command <<-EOH
      /opt/vFabric/#{new_resource.instance_name}/bin/tcruntime-ctl.sh start
    EOH
    
  end
  new_resource.updated_by_last_action(true)
end
