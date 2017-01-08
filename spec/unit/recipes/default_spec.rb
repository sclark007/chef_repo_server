#
# Cookbook Name:: tsa_gemirro
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# require 'spec_helper'
#
# describe 'tsa_gem_server::default' do
#   before do
#     Fauxhai.mock(platform: 'centos', version: '7.2.1511')
#   end
#
#   let(:chef_run) do
#     runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
#     runner.converge(described_recipe)
#   end
#
#   it 'converges successfully' do
#     expect { chef_run }.to_not raise_error
#   end
#
#   it 'installs httpd' do
#     expect(chef_run).to install_package 'httpd-2.4.6'
#   end
#
#   it 'enables the httpd service' do
#     expect(chef_run).to enable_service 'httpd'
#   end
#
#   it 'starts the httpd service' do
#     expect(chef_run).to start_service 'httpd'
#   end
# end
