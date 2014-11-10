#
# Author:: Noah Kantrowitz <noah@coderanger.net>
#
# Copyright 2013-2014, Balanced, Inc.
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

name 'balanced-rundeck'
version '1.2.20'

maintainer 'Balanced'
maintainer_email 'dev@balancedpayments.com'
license 'Apache 2.0'
description 'Installs/Configures rundeck for Balanced'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends 'balanced-citadel'
depends 'balanced-user', '~> 1.0.14'
depends 'rundeck', '~> 99.1.0'
depends 'partial_search', '~> 1.0.7'
depends 'rundeck-fabric', '~> 1.0.0'
