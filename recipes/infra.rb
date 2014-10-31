rundeck_project 'infra-db' do

  default_node_query = "roles:db-secondary-#{node['balanced-rundeck']['app_environment']} AND chef_environment:#{node.chef_environment}"
  node_query = node['balanced-rundeck']['jobs']['db']['archiver_query'] || default_node_query

  rundeck_node_source_file 'infra-db' do
    query node_query
    limit 1
    nodes node['balanced-rundeck']['jobs']['infra-db']['nodes']
  end

  if node['balanced-rundeck']['jobs']['db']['specify_host']
    # this is the ip address of the host param passed to the pg_dump command
    host = node['postgres']['archiver']
  else
    host = nil
  end

  archiver_environment = node['balanced-rundeck']['jobs']['db']['archiver_environment'] || node['balanced-rundeck']['app_environment']

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
          :app_environment => node['balanced-rundeck']['app_environment'],
          :archiver_environment => archiver_environment
      )
    end
  end
end

rundeck_project 'infra-db-cluster' do

  rundeck_node_source_file 'infra-db-cluster' do
    query "roles:db-primary-#{node['balanced-rundeck']['app_environment']} AND chef_environment:#{node.chef_environment} AND tags:primary"
    limit 1
    nodes node['balanced-rundeck']['jobs']['infra-db-cluster']['nodes']
  end

  rundeck_job "backup cluster" do
    source 'jobs/db/backup-cluster.yml.erb'
    options(
        :failure_recipient => node['balanced-rundeck']['jobs']['failure_recipient'],
        :failure_notify_url => node['balanced-rundeck']['jobs']['failure_notify_url'],
        :chef_environment => node.chef_environment,
        :app_environment => node['balanced-rundeck']['app_environment'],
    )
  end

end
