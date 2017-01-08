chef_repo_server
================

To often when we build chef automation pipelines and we need access to a gem api and the chef rpm repositories. this cookbook is intended to setup both.

Requirements
============

## Platforms

## chef
- Chef 12.1+

## cookbooks
- `cron` add reposync and create repo tasks to cron
- `ssl_certificate` configure apache with ssl support
- `apache2` https service.

Usage
=====

Using this cookbook is relatively straightforward. It is recommended to create
a project or organization specific [wrapper cookbook](https://www.chef.io/blog/2013/12/03/doing-wrapper-cookbooks-right/)
and add the desired recipes to the run list of a node, or create a role. Depending on your
environment, you may have multiple roles that use different recipes
from this cookbook. Adjust any attributes as desired. For example, to
create a basic role for web servers that provide both HTTP and HTTPS:

```ruby
    % cat recipes/server.rb
    chef_repo_server_mirror 'chef-7' do
      repo_name 'chef-7'
      repo_description 'Chef Packages for Enterprise Linux 7'
      repo_baseurl "#{node['chef_repo_server']['repo_server']}/repos/yum/stable/el/7/x86_64/"
      action :create
    end
```

For examples of using the definitions in your own recipes, see their
respective sections below.

Attributes
==========

- `['chef_repo_server']['gems']` list of gems to be added to the config.ru
- `['chef_repo_server']['basepath']` base directory for storing gems and chef rpms.
- `['chef_repo_server']['repo_server']` server were chef rpm's can be downloaded

# Resources
## chef_repo_server_mirror
- `local_path` location
- `repo_name` repo name
- `repo_description` descrption
- `repo_baseurl` repo url


**Author: ** Steve Clark <steve@bigsteve.us>  
** Copyright (c) ** 2016 Steve Clark  

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
