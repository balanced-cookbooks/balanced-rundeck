default['rundeck']['user'] = default['rundeck']['ssh']['user'] = 'rundeck'

default['rundeck']['admin']['username'] = 'balanced'
default['rundeck']['admin']['password'] = 'balanced'
# this is document but apparently not working.
# https://github.com/priestjim/chef-rundeck#defaultrb
default['rundeck']['admin']['ssh_key'] = citadel['deploy_key/deploy.pem']

default['rundeck']['deb_version'] = '2.0.1'
default['rundeck']['deb_checksum'] = '535bfebdf04e60dd56c64946f6a692ccf9e45bd5'
