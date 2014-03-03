include_recipe 'balanced-rundeck::default'

%w(/tmp/rundeck /tmp/rundeck/jobs).each do |path|
  directory path do
    action :create
    owner "rundeck"
    group "rundeck"
  end
end


%w(invoicing).each do |job_name|
  path = "/tmp/rundeck/jobs/#{job_name}.yml"
  template path do
    source "balanced/jobs/#{job_name}.yml"
    owner "rundeck"
    group "rundeck"
    mode 00600
    action :create_if_missing
  end

  execute "upload #{job_name}" do
    command "rd-jobs load --file #{path} -F yaml"
  end

end
