#
# Cookbook Name:: matt-base
# Recipe:: users
#
# The MIT License (MIT)
#
node['matt-base']['users'].each do |username, data|
  group username do
    action :create
  end

  user_home = "/home/#{username}"

  user username do
    action :create
    gid username
    manage_home true
    home user_home
    shell data['shell']
    password data['password']
  end

  %w(.ssh bin scripts scratch).each do |dir|
    directory File.join(user_home, dir) do
      owner username
      group username
    end
  end

  if data.attribute?('authorized_keys')
    template File.join(user_home, '.ssh', 'authorized_keys') do
      owner username
      group username
      variables ssh_keys: data['authorized_keys']
    end
  end

  if data['sudo']
    group 'sudo' do
      action :modify
      members username
      append true
    end
  end
end
