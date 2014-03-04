include_recipe 'apt'

include_recipe 'balanced-rundeck::default'


%w(/tmp/rundeck /tmp/rundeck/jobs).each do |path|
  directory path do
    action :create
    owner "rundeck"
    group "rundeck"
  end
end

if Chef::Config[:solo]
  nodes = [
      {
          :name => 'server1',
          :fqdn => 'server1.vandelay.io',
          :tags => 'bwrk-prod-a-10-30-2-123, roles:balanced-api',
      },
      {
          :name => 'server2',
          :fqdn => 'server2.vandelay.io',
          :tags => 'bapi-prod-a-10-30-2-123, roles:balanced-worker',
      }
  ]
else
  nodes = partial_search(:node)
end

%w(balanced precog).each do |project|

  remote_directory "/var/rundeck/projects" do
    owner "rundeck"
    group "rundeck"
    files_mode 00644
    mode 00755
    action :create_if_missing
    overwrite true
    source "rundeck/#{project}/projects"
    #notifies :restart, 'service[rundeckd]'
  end

  template "/var/rundeck/projects/#{project}/etc/resource.yml" do
    source 'nodes.yml'
    owner "rundeck"
    group "rundeck"
    variables(
        :nodes => nodes
    )
  end

  remote_directory "/tmp/rundeck/#{project}/jobs" do
    owner "rundeck"
    group "rundeck"
    files_mode 00600
    action :create_if_missing
    overwrite true
    source "rundeck/#{project}/jobs"
  end

  execute "upload jobs" do
    command <<-EOH
  for file in /tmp/rundeck/#{project}/jobs/*
  do
    rd-jobs load --file $file -F yaml
  done
    EOH
  end

end
