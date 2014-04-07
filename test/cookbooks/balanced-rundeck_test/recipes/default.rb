include_recipe 'balanced-rundeck'

# Create projects
rundeck_project 'balanced' do
  rundeck_node_source_file 'balanced'

  rundeck_job 'echo' do
    source 'balanced_echo.yml'
  end

  rundeck_job 'invoicing' do
    source 'balanced_invoicing.yml'
  end
end

rundeck_project 'precog' do
  rundeck_node_source_file 'precog'

  rundeck_job 'stats' do
    source 'precog_stats.yml'
  end
end
