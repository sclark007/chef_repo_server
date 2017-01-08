# encoding: utf-8
#
# Author:: Steve Clark <steve@bigsteve.us>
# Copyright (c) 2016 Steve Clark
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# rpms needed for creating a yum repo
default['chef_repo_server']['rpms'] = [
  'createrepo',
  'yum-utils'
]

# install lastest version of gems
default['chef_repo_server']['gems'] = {
  'chef-ruby-lvm-attrib' => '~> 0.0',
  'chef-ruby-lvm' => '~> 0.0',
  'chef-vault' => '~> 2.9',
  'inspec' => '~> 1.8',
  'mixlib-install' => '~> 2.1',
  'rake' => '~> 12.0',
  'stove' => '~> 4.1',
  'chef-dk' => '~> 1.1'
}

default['chef_repo_server']['basepath'] = '/repos'

# ssl cert setup
default['chef_repo_server']['repo_server'] = 'https://packages.chef.io'
default['chef_repo_server']['common_name'] = node['fqdn']
default['chef_repo_server']['ssl_cert']['source'] = 'self-signed'
default['chef_repo_server']['ssl_key']['source'] = 'self-signed'

## apache
default['apache']['listen'] = ['*:443', '*:9443']
