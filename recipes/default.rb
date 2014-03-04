include_recipe 'balanced-user'

# https://github.com/priestjim/chef-rundeck/pull/2
user 'rundeck'

balanced_user 'rundeck' do
  sudo true
  ssh_keys [
     'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCt91wY1t0J07gGuzocAgWNTm56zv9GfotqdhpB+r/3vSTJnXTd9wuU93Qv7Pv9Pdv4gLAcRBy79hV9oWrrSl0twld7XZ6eXQpZNq2dko3J2diyoy0KJg8H6pnNozKIGI6o44HVBEy5nFze+PXpHChwoDVCaABYmV1OEKXk841MzVpbiJwebasqs+nh3VOxSXTOBQRFnN6V4Prf36tLrljsV0DwulY9rttSyEXrjn3LGLshLbPEq9v5J3yRb/QftlOOfkuZZBBiC2L9HTh8CsdfNachUKwsXXV1/kkzBGfcdrgGzZcMp33Vdui8SCORtpm9mcQ5FGqe12t015L1vToX deploy@balanced',
  ]
end
