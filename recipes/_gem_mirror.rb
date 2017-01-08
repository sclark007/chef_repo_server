# encoding: utf-8
# Cookbook Name:: chef_repo_server
# Recipe:: default
#
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

include_recipe 'cron'

# install the gem
chef_gem 'gem-mirror' do
  action :install
  compile_time true
end

directory "#{node['chef_repo_server']['basepath']}/gems/public/gems" do
  owner 'root'
  group 'root'
  mode 0o0755
  recursive true
  action :create
end

# set config file
template "#{node['chef_repo_server']['basepath']}/gems/config.rb" do
  source 'config.rb.erb'
  owner 'root'
  group 'root'
  variables(
    packages: node['chef_repo_server']['gems']
  )
  mode 0o0744
  notifies :run, 'execute[gem-mirror_update]', :delayed
  notifies :run, 'execute[gem-mirror_index]', :delayed
end

cron_d 'update-gem-mirror' do
  minute  0
  hour    23
  predefined_value '@hourly'
  home '/repos/gems'
  command '/opt/chef/embedded/bin/gem-mirror update && /opt/chef/embedded/bin/gem-mirror index'
  user    'root'
end

execute 'gem-mirror_update' do
  cwd '/repos/gems'
  command '/opt/chef/embedded/bin/gem-mirror update'
  action :nothing
end

execute 'gem-mirror_index' do
  cwd '/repos/gems'
  command '/opt/chef/embedded/bin/gem-mirror index'
  action :nothing
end
