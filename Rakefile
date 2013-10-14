require 'rubygems'
require 'rake'
require 'echoe'


Echoe.new('navGATE','0.1.02') do |p|
  p.description = "Allows the easy creation of menus with config files"
  p.url = "https://github.com/Thermatix/navGATE"
  p.author = "Martin Becker"
  p.email = "mbeckerwork@gmail.com"
  p.ignore_pattern = []
  p.development_dependencies =[]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|ext| load ext}