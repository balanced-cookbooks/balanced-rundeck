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

balanced_user 'cmdr' do
  sudo true
  ssh_keys [
     'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCt91wY1t0J07gGuzocAgWNTm56zv9GfotqdhpB+r/3vSTJnXTd9wuU93Qv7Pv9Pdv4gLAcRBy79hV9oWrrSl0twld7XZ6eXQpZNq2dko3J2diyoy0KJg8H6pnNozKIGI6o44HVBEy5nFze+PXpHChwoDVCaABYmV1OEKXk841MzVpbiJwebasqs+nh3VOxSXTOBQRFnN6V4Prf36tLrljsV0DwulY9rttSyEXrjn3LGLshLbPEq9v5J3yRb/QftlOOfkuZZBBiC2L9HTh8CsdfNachUKwsXXV1/kkzBGfcdrgGzZcMp33Vdui8SCORtpm9mcQ5FGqe12t015L1vToX deploy@balanced',
  ]
end
