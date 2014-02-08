#
# Cookbook Name:: kafka
# Recipe:: _setup
#

group node[:kafka][:group]

user node[:kafka][:user] do
  gid   node[:kafka][:group]
  shell '/sbin/nologin'
  supports(manage_home: false)
end

[
  node[:kafka][:install_dir],
  node[:kafka][:config_dir],
  node[:kafka][:log_dir],
  File.join(node[:kafka][:install_dir], 'build')
].each do |dir|
  directory dir do
    owner     node[:kafka][:user]
    group     node[:kafka][:group]
    mode      '755'
    recursive true
    not_if { File.directory?(dir) }
  end
end
