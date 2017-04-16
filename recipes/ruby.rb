#
# Cookbook Name:: matt-base
# Recipe:: ruby
#
# The MIT License (MIT)
#
include_recipe 'ruby_build::default'
include_recipe 'ruby_rbenv::system_install'

members = []
node['matt-base']['rbenv']['users'].each do |user, enabled|
  members << user if enabled
end

group 'rbenv' do
  action :create
  members members
end

node['matt-base']['ruby']['versions'].each do |version, data|
  next unless data['enabled']
  rbenv_ruby version do
    action :install
  end

  if node['matt-base']['ruby']['global_version'] == version
    rbenv_global version
  end

  rbenv_gem 'bundler' do
    rbenv_version version
    action :install
  end
end

# Sigh. Make it so any user in the rbenv group can install gems (this is not
# ideal, but this is for my personal workstation anyway. So I don't care as
# much about the safety.
execute 'fix-rbenv-permissions' do
  command 'chgrp -R rbenv /usr/local/rbenv && chmod -R g+w /usr/local/rbenv'
end
