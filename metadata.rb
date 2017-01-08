name 'chef_repo_server'
maintainer 'Steve Clark'
maintainer_email 'steve@bigsteve.us'
license 'Apache 2.0'
description 'Installs/Configures chef_repo_server'
long_description 'Installs/Configures chef_repo_server'
version '0.1.0'

depends 'cron'
depends 'ssl_certificate'
depends 'apache2'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/' if respond_to?(:source_url)
