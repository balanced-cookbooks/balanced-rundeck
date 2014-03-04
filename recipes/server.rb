include_recipe 'apt'
#include_recipe 'role-base'

include_recipe 'balanced-rundeck::default'

include_recipe 'rundeck::default'


%w(/tmp/rundeck /tmp/rundeck/jobs /var/lib/rundeck /var/lib/rundeck/.ssh).each do |path|
  directory path do
    action :create
    mode 00700
    owner "rundeck"
    group "rundeck"
  end
end

if Chef::Config[:solo]
  nodes = [
      {
          :name => '10.2.3.7',
          :fqdn => 'server1.vandelay.io',
          :tags => 'bwrk-prod-a-10-30-2-123, roles:balanced-api',
      },
      {
          :name => '10.2.3.8',
          :fqdn => 'server2.vandelay.io',
          :tags => 'bapi-prod-a-10-30-2-123, roles:balanced-worker',
      }
  ]
else
  nodes = partial_search(:node)
end

file '/home/rundeck/.ssh/deploy.pem' do
  content citadel['deploy_key/deploy.pem']
  mode '400'
  owner node['rundeck']['user']
  group node['rundeck']['user']
end

template '/home/rundeck/.ssh/config' do
  source 'rundeck_ssh_config.erb'
  mode '400'
  owner node['rundeck']['user']
  group node['rundeck']['user']
end

link '/var/lib/rundeck/.ssh/id_rsa' do
  to '/home/rundeck/.ssh/deploy.pem'
end


%w(balanced precog).each do |project|

  remote_directory "/var/rundeck/projects" do
    owner node['rundeck']['user']
    group node['rundeck']['user']
    files_mode 00644
    mode 00755
    action :create_if_missing
    overwrite true
    source "rundeck/#{project}/projects"
    #notifies :restart, 'service[rundeckd]'
  end

  template "/var/rundeck/projects/#{project}/etc/resource.yml" do
    source 'nodes.yml.erb'
    owner node['rundeck']['user']
    group node['rundeck']['user']
    variables(
        :nodes => nodes,
        :user => node['rundeck']['user']
    )
  end

  remote_directory "/tmp/rundeck/#{project}/jobs" do
    owner node['rundeck']['user']
    group node['rundeck']['user']
    files_mode 00600
    action :create_if_missing
    overwrite true
    source "rundeck/#{project}/jobs"
  end

  execute "upload jobs" do
    command <<-EOH
  set -x
  for file in /tmp/rundeck/#{project}/jobs/*
  do
    rd-jobs load --file $file -F yaml
  done
    EOH
  end

end
