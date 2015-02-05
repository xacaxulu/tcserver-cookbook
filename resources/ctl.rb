actions :start

default_action :start

attribute :instance_name, :name_attribute => true, :kind_of => String
attribute :java_home, kind_of: String
attribute :catalina_base, kind_of: String