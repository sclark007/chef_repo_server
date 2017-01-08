
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

property :name, [String, Symbol], required: true, name_property: true
property :local_path, String, required: false
property :repo_name, String, required: true
property :repo_description, String, required: true
property :repo_baseurl, String, required: true

default_action :create

def real_local_path
  if local_path == NilClass
    "#{local_path}/#{name}/"
  else
    "#{node['chef_repo_server']['basepath']}/"
  end
end

# Needs to be def'd as path for zap to work.
def path
  "/etc/reposync.repos.d/#{repo_name}.repo"
end

# rubocop:disable Metrics/BlockLength
action :create do
  directory '/etc/reposync.repos.d/' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  cookbook_file '/etc/reposync.conf' do
    cookbook 'chef_repo_server'
    source 'reposync.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

  template path do
    cookbook 'chef_repo_server'
    source 'repo.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      repo_name: repo_name,
      repo_description: repo_description,
      repo_baseurl: repo_baseurl
    )
    notifies :run, "execute[#{repo_name}-reposync-once]", :delayed
    action :create
  end
  directory real_local_path do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end

  cron_d "#{repo_name}-reposync" do
    predefined_value '@hourly'
    command "reposync -n -d -c /etc/reposync.conf -r #{repo_name} -p #{real_local_path}"
    user    'root'
  end

  cron_d "#{repo_name}-createrepo" do
    predefined_value '@hourly'
    command "createrepo -d -s sha -C #{real_local_path}#{repo_name}"
    user    'root'
  end

  execute "#{repo_name}-reposync-once" do
    command "reposync -n -d -c /etc/reposync.conf -r #{repo_name} -p #{real_local_path}"
    action :nothing
  end
end

# rubocop:enable Metrics/BlockLength
action :delete do
  file path do
    action :delete
  end
  directory real_local_path do
    recursive true
    action :delete
  end
  yum_repository repo_name do
    action :delete
  end
end
