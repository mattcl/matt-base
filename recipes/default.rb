#
# Cookbook Name:: matt-base
# Recipe:: default
#
# The MIT License (MIT)
#

include_recipe 'matt-base::packages'
include_recipe 'matt-base::users'
include_recipe 'matt-base::user_packages'
