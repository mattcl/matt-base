#
# Cookbook Name:: matt-base
# Recipe:: vim
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
git '/tmp/vim' do
  repository 'https://github.com/vim/vim.git'
  action :sync
  notifies :run, 'execute[compile-vim]', :immediately
end

execute 'compile-vim' do
  command "cd /tmp/vim && ./configure #{node['matt-base']['vim']['configuration']} \ && make -j 3 && sudo make install" # rubocop:disable Metrics/LineLength
  action :nothing
end

include_recipe 'apt'
include_recipe 'git'
include_recipe 'build-essential::default'

node.set['cmake']['install_method'] = 'source'

include_recipe 'cmake::default'

node['matt-base']['users'].each do |username, _|
  user_home = "/home/#{username}"

  # clone from git .vim repo
  git "#{user_home}/.vim" do
    repository node['matt-base']['vim']['config_repo']
    revision 'master'
    user username
    group username
    action :sync
    notifies :run, 'execute[install-vim-bundles]', :delayed
  end

  # add external vimrc
  template File.join(user_home, '.vimrc') do
    source 'vimrc.erb'
    user username
    group username
    mode 0644
    action :create_if_missing
  end

  # this folder isn't tracked by the vim repo, so it needs to be created
  directory File.join(user_home, '.vim', 'bundle') do
    owner username
    group username
  end

  # install vundle
  git "#{user_home}/.vim/bundle/Vundle.vim" do
    repository node['matt-base']['vim']['vundle_repo']
    revision 'master'
    user username
    group username
    action :sync
  end

  execute 'install-vim-bundles' do
    user username
    environment 'HOME' => user_home
    cwd user_home
    command 'vim -E -s -c "source ~/.vimrc" -c PluginInstall -c qa'
    action :nothing
    notifies :run, 'execute[compile-ycm]', :delayed
  end

  # compile you complete me if it is installed
  ycm_path = "#{user_home}/.vim/bundle/YouCompleteMe"
  execute 'compile-ycm' do
    user username
    cwd ycm_path
    command "./install.sh#{node['matt-base']['vim']['ycm_install_flags']}"
    only_if { File.exist?(ycm_path) }
    action :nothing
  end
end
