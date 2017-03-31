require 'chef/cookbook/metadata'

metadata_file = ARGV.first || 'metadata.rb'

metadata = Chef::Cookbook::Metadata.new
metadata.from_file(metadata_file)

puts "#{metadata.name}_#{metadata.version}"
