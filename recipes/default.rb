include_recipe 'apt'
#
## specifying the install dir is fucked in rundeck recipe
#link "/var/lib/rundeck" do
#  to "/opt/rundeck"
#  not_if { ::File.directory?("/var/lib/rundeck") }
#end

# https://github.com/priestjim/chef-rundeck/pull/2
user 'rundeck'

include_recipe 'rundeck::default'

