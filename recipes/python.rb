#
# Cookbook Name:: matt-base
# Recipe:: python
#
# The MIT License (MIT)
#

# install python 3 first so we don't end up defaulting to python 3
python_runtime '3' do
  version node['matt-base']['python3']['version']
  pip_version node['matt-base']['python3']['pip_version']
  setuptools_version node['matt-base']['python3']['setuptools_version']
  provider :system
  options :system, dev_package: true
end

node['matt-base']['python3']['packages'].each do |name, vers|
  python_package name do
    version vers if vers
    python '3'
  end
end

python_runtime '2' do
  version node['matt-base']['python2']['version']
  pip_version node['matt-base']['python2']['pip_version']
  setuptools_version node['matt-base']['python2']['setuptools_version']
  provider :system
  options :system, dev_package: true
end

node['matt-base']['python2']['packages'].each do |name, vers|
  python_package name do
    version vers if vers
    python '2'
  end
end
