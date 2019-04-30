script = "#{Chef::Config['file_cache_path']}/rust-init.sh"

remote_file script do
  source 'https://sh.rustup.rs'
  mode '0755'
end

node['matt-base']['users'].each do |username, data|
  execute "install-rustup_#{username}" do
    command "#{script} -y -v"
    user username
    environment ({'HOME' => "/home/#{username}"})
  end
end
