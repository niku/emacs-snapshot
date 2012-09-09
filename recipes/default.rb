#
# Cookbook Name:: emacs-snapshot
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node[:platform]
when 'debian'
  apt_repository "emacs-snapshot" do
    uri 'http://emacs.naquadah.org/'
    distribution node['lsb']['codename']
    components ['main']
    key 'http://emacs.naquadah.org/key.gpg'
  end
when 'ubuntu'
  apt_repository "emacs-snapshot" do
    uri "http://ppa.launchpad.net/cassou/emacs/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "CEC45805"
  end
end

template "/etc/apt/sources.list.d/emacs-snapshot.list" do
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

package 'emacs-snapshot' do
  action :install
end
