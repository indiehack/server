#
# Cookbook Name:: indiehack
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'mongodb'
package 'apache'

include_recipe "nodejs::iojs"

nodejs_npm 'typescript'

#include_recipe 'mongodb'
nodejs_npm 'mongoose'
nodejs_npm 'strongloop'

nodejs_npm 'forever'
