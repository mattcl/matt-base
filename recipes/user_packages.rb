#
# Cookbook Name:: matt-base
# Recipe:: user_packages
#
# The MIT License (MIT)
#
node['matt-base']['users'].each do |username, _|
  user_home = "/home/#{username}"

  # install oh-my-zsh
  git File.join(user_home, '.oh-my-zsh') do
    repository node['matt-base']['oh-my-zsh']['url']
    revision 'master'
    user username
    group username
    action :sync
  end

  template File.join(user_home, '.zshenv') do
    source 'zshenv.erb'
    owner username
    group username
    mode 0644
    action :create_if_missing
  end

  template File.join(user_home, '.oh-my-zsh', 'themes', 'matt.zsh-theme') do
    owner username
    group username
    mode 0644
    action :create
  end

  # install zsh plugins
  node['matt-base']['oh-my-zsh']['additional_plugins'].each do |name, data|
    git File.join(user_home, '.oh-my-zsh', 'plugins', name) do
      repository data['url']
      revision 'master'
      user username
      group username
      action :sync
    end
  end

  template File.join(user_home, '.zshrc') do
    source 'zshrc.erb'
    owner username
    group username
    mode 0644
    action :create_if_missing
  end

  # install fzf
  git File.join(user_home, '.fzf') do
    repository node['matt-base']['fzf']['url']
    revision 'master'
    user username
    group username
    action :sync
    notifies :run, 'execute[install-fzf]', :delayed
  end

  execute 'install-fzf' do # ~FC041
    environment ({'HOME' => user_home})
    user username
    cwd user_home
    command '~/.fzf/install --key-bindings --no-update-rc --completion'
    action :nothing
  end

  # tmux
  template File.join(user_home, '.base-tmux.conf') do
    source 'base-tmux.conf.erb'
    user username
    group username
    mode 0644
    action :create
  end

  template File.join(user_home, '.tmux.conf') do
    source 'tmux.conf.erb'
    user username
    group username
    mode 0644
    action :create_if_missing
    variables(user_home: user_home)
  end

  # tigrc
  template File.join(user_home, '.tigrc') do
    source 'tigrc.erb'
    user username
    group username
    mode 0644
    action :create_if_missing
  end

  # fonts
  conf_dir = '.config/fontconfig/conf.d'
  conf_dir.split('/').inject(user_home) do |cur, dir|
    cur = File.join(cur, dir)
    directory cur do
      owner username
      group username
    end

    cur
  end

  directory File.join(user_home, '.fonts') do
    owner username
    group username
  end

  remote_file File.join(user_home, '.fonts', 'PowerlineSymbols.otf') do
    source node['matt-base']['powerlinefonts']['font']
    owner username
    group username
    mode 0644
    action :create
  end

  remote_file File.join(user_home, conf_dir, '10-powerline-symbols.conf') do
    source node['matt-base']['powerlinefonts']['config']
    owner username
    group username
    mode 0644
    action :create
  end
end
