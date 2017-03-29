#
# Cookbook Name:: matt-base
# Recipe:: full
#
# The MIT License (MIT)

include_recipe 'matt-base::default'
include_recipe 'matt-base::python'
include_recipe 'matt-base::ruby'
include_recipe 'matt-base::vim'
