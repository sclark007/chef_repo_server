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

node['chef_repo_server']['rpms'].each do |y|
  yum_package y do
    action :install
  end
end

directory "#{node['chef_repo_server']['basepath']}/chef" do
  owner 'root'
  group 'root'
  mode 0o0755
  recursive true
  action :create
end
