rundeck_project 'infra-db' do
  rundeck_node_source_file 'infra-db' do
    query "roles:db-secondary-#{node['balanced-rundeck']['app_environment']} AND chef_environment:#{node.chef_environment}"
    limit 1
  end

  if node['balanced-rundeck']['jobs']['db']['specify_host']
    host = node['postgres']['archiver']
  else
    host = nil
  end

  %w(balanced precog justice).each do |db_name|
    rundeck_job "backup #{db_name}" do
      source 'jobs/db/backup.yml.erb'
      options(
          :db_name => db_name,
          :user => db_name,
          # HACK: currently the prod db is running on old architecture. we
          # specify the host for this combination because we're not using
          # localhost to backup the prod db, it's another server.
          :host => host,
          :failure_recipient => node['balanced-rundeck']['jobs']['failure_recipient'],
          :failure_notify_url => node['balanced-rundeck']['jobs']['failure_notify_url'],
          :chef_environment => node.chef_environment,
          :app_environment => node['balanced-rundeck']['app_environment']
      )
    end
  end
end
