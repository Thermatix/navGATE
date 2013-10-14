require 'navgate'
#building menu object from scratch
# NAVGATE = Navgate.new do |build|
#   build.navs = [ Navgate::Builder.new do |options|
#           options[:selection] = %w(selection site_settings users images misc)
#           options[:namespace] = 'admin'
#           options[:controller] = 'admin_panel'
#         end
#   ]
# end
#
#building menu object from database fields be sure to pass it as {Model_name: field}
# NAVGATE = Navgate.new do |build|
#    build.navs = [ Navgate::Builder.new do |options|
#                   options[:selection] = {categories: :title }
#                   options[:prefix] = 'shop_category'
#                   options[:controller] = 'front_page'
#                   options[:by_id] = true
#                 end
#   ]
# end
#
#building from yaml file, look through the yaml file for an example
# NAVGATE = Navgate.new do |build|
#   build.navs = "#{Rails.root}/config/build_menu.yml"
# end