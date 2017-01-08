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

# we need to save the resource variable to get the key and certificate file
# paths
cert = ssl_certificate 'gem-server' do
  common_name node['chef_repo_server']['common_name']
  # common_name '127.0.0.1'
  # we want to be able to use node['my-webapp'] to configure the certificate
  namespace node['my-webapp']
  notifies :restart, 'service[apache2]'
end

include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'

web_app 'chef-server' do
  port '443'
  # this cookbook includes a virtualhost template for apache2
  cookbook 'ssl_certificate'
  server_name cert.common_name
  docroot "#{node['chef_repo_server']['basepath']}/chef"
  directory_options 'Indexes FollowSymLinks MultiViews'
  ssl_key cert.key_path
  ssl_cert cert.cert_path
  ssl_chain cert.chain_path
end

web_app 'gem-server' do
  port '9443'
  # this cookbook includes a virtualhost template for apache2
  cookbook 'ssl_certificate'
  server_name cert.common_name
  docroot "#{node['chef_repo_server']['basepath']}/gems/public/"
  directory_options 'Indexes FollowSymLinks MultiViews'
  ssl_key cert.key_path
  ssl_cert cert.cert_path
  ssl_chain cert.chain_path
end
