use_inline_resources

action :create do
  execute "create_#{new_resource.instance_name}" do
    cwd '/opt/vFabric'
    ENV['JAVA_HOME'] = new_resource.java_home
    ENV['CATALINA_BASE'] = new_resource.catalina_base
    user 'root'
    group 'root'
    command <<-EOH
      cd /opt/vFabric ; 
      export JAVA_HOME=#{new_resource.java_home} ; 
      inst=#{new_resource.instance_name} ; 
      ./#{new_resource.basename}/tcruntime-instance.sh create -v #{new_resource.tc_server_version} --interactive --property bio.http.port=80#{new_resource.port} --property bio.https.port=84#{new_resource.port} --property base.jmx.port=88#{new_resource.port} --property base.shutdown.port=-1 --property base.runtime.user=tomcat $inst; 
      chmod 750 $inst ; chmod 750 $inst/logs/ ;
      ln -sf /opt/vFabric/#{new_resource.instance_name}/bin/init.d.sh /etc/init.d/#{new_resource.instance_name}
      chkconfig $inst on ; chown -R tomcat:tomcat $inst ; 
      rm -fr $inst/webapps/ROOT ; 
    EOH
  end

  template "/opt/vFabric/#{new_resource.instance_name}/bin/setenv.sh" do
    source 'setenv.erb'
    variables({
      :java_home => new_resource.java_home
    })
  end

  new_resource.updated_by_last_action(true)
end
