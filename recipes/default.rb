#
# Author:: Noah Kantrowitz <noah@coderanger.net>
#
# Copyright 2014, Balanced, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'balanced-user'

# Install Rundeck
rundeck node['rundeck']['node_name'] do
  cli_password citadel['rundeck/cli_password']
  ssh_user 'cmdr'
  ssh_key citadel['balanced_cmdr/rundeck.pem']
end

# Create users (if they have a password in S3)
run_context.resource_collection.each do |r|
  if r.is_a?(Chef::Resource::BalancedUser) && r.action != :nothing
    begin
      password = citadel["rundeck/#{r.username}_password"].chomp
    rescue Citadel::CitadelError
      Chef::Log.debug("Skipping #{r.username} as no password is set in citadel")
      next
    end
    rundeck_user r.username do
      password password
      roles %w{admin user}
    end
  end
end
