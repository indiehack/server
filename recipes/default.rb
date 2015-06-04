#
# Cookbook Name:: indiehack
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'gcc'
package 'make'
package 'build-essential'
package 'mongodb'
#package 'apache2'

include_recipe "nodejs::iojs"

nodejs_npm 'typescript'

# not necesarilly needed, is it ?
nodejs_npm 'mongoose'
nodejs_npm 'strongloop'
nodejs_npm 'loopback-connector-mongodb'
nodejs_npm 'mongo-express'
nodejs_npm 'gulp'
nodejs_npm 'bower'

#nodejs_npm 'forever'

# workaround - current Vagrant cant do it with ubuntu 15
bash 'set-hostname' do 
	user 'root'
	code "hostnamectl set-hostname inha"
end
