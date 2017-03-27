rbenv_users = []
node['matt-base']['rbenv']['users'].each do |user, enabled|
  rbenv_users << user if enabled
end

node.set['rbenv']['group_users'] = rbenv_users

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

node['matt-base']['ruby']['versions'].each do |version, data|
  next unless data['enabled']
  rbenv_ruby version do
    global true if node['matt-base']['ruby']['global_version'] == version
  end

  rbenv_execute 'update-rubygems' do
    command 'gem update --system'
    ruby_version version
  end

  # this is inefficient, since we're doing it every time, but this is just so
  # I don't need another loop to install the gems for a given version
  execute 'fix-rbenv-permissions' do
    command 'chmod -R g+w /opt/rbenv/versions'
  end

  rbenv_gem 'bundler' do
    ruby_version version
  end

  data['gems'].each do |gem, install|
    next unless install

    rbenv_gem gem do
      ruby_version version
    end
  end
end
