actions :create

default_action :create

attribute :instance_name, :name_attribute => true, :kind_of => String
attribute :tc_server_version, :kind_of => String, :default => false
attribute :java_home, :kind_of => String, :default => false
attribute :catalina_base, :kind_of => String, :default => false
attribute :basename, :kind_of => String, :default => false
attribute :port, :kind_of => String, :default => false
attribute :force, :kind_of => [TrueClass, FalseClass], :default => false

