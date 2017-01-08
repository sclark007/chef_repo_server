# encoding: utf-8

# Inspec test for recipe chef_repo_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe port(443) do
  it { should be_listening }
end
describe port(9443) do
  it { should be_listening }
end
