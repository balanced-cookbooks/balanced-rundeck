rundeck_project 'infra-db' do
  rundeck_node_source_file 'infra-db' do
    query "roles:balanced-db AND chef_environment:#{node.chef_environment}"
    limit 1
  end

  %w(balanced precog).each do |db_name|
    rundeck_job "backup #{db_name}" do
      source 'jobs/db/backup.yml.erb'
      options(
          :db_name => db_name,
          :user => db_name,
          :host => node['postgres']['master'],
          :failure_recipient => node['balanced-rundeck']['jobs']['failure_recipient'],
          :failure_notify_url => node['balanced-rundeck']['jobs']['failure_notify_url'],
          :chef_envrionment => node.chef_environment
      )
    end
  end
end
