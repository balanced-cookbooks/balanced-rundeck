include_recipe 'balanced-user'

# https://github.com/priestjim/chef-rundeck/pull/2
user 'rundeck'

balanced_user 'rundeck' do
  sudo true
  ssh_keys [
     'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClYhtXQPxx7FBOer6b9RDuXu3lKbUVs5HMJKXNbXKjQKkMeq7xHGRN0/jX0wu7ZRX6NmAjykqd4xUq6b4SXO8voL4jltbGkbqUD59WNipjlZ5ZF6TSda1cDREcqGdGMGuK6/IQujwOE45xX8WFzvSE5Xx1RI9LeGuWT9a1BC8ivhwtQNBA9mNzVDcWql8tq9LDh/xRsrqls/ul+XT5Ti0EviTdycCi3DSo2aPKYnwYm8vE5gP/lRlxSpDYP4y7WuE88PL4rCOY+3D1zBVPfRqKz+DVAyXXsoVJ1pLKBVKeiAhr3COWSkZIVr4/3IcHRzePyHDbMTUZfEZxKVh8Vnmb ai@ai-xg41',
  ]
end

include_recipe 'rundeck::default'

