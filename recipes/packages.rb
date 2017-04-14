#
# Cookbook Name:: matt-base
# Recipe:: packages
#
# The MIT License (MIT)
#
include_recipe 'apt'

if node['platform'] == 'ubuntu' && node['platform_version'] == '16.04'
  node.override['matt-base']['packages']['installed']['python-minimal'] = nil
end

node['matt-base']['packages']['installed'].each do |name, vers|
  package name do
    if vers == :latest
      action :upgrade
    else
      action :install
      version vers if vers
    end
  end
end

include_recipe 'git'
include_recipe 'tig'
include_recipe 'zsh'
include_recipe 'build-essential::default'

node.set['cmake']['install_method'] = 'source'
include_recipe 'cmake::default'

# exa was built locally and checked into the cookbook
cookbook_file '/usr/local/bin/exa' do
  source 'exa'
  mode 0755
end

ssh_known_hosts_entry 'github.com'

ark 'tmux' do
  url node['matt-base']['tmux']['url']
  action :install_with_make
end

ark 'rg' do
  url node['matt-base']['ripgrep']['url']
  has_binaries ['rg']
  action :install
end
