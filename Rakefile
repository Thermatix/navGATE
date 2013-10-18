require 'rubygems'
require 'rake'
require 'echoe'


Echoe.new('navGATE','0.1.19') do |p|
  p.summary = "Allows the easy creation of navigation with config files"
  p.description = "Can create navigation from objects using the nav builder,from database tables or from a yaml file"
  p.url = "https://github.com/Thermatix/navGATE"
  p.author = "Martin Becker"
  p.email = "mbeckerwork@gmail.com"
  p.ignore_pattern = []
  p.development_dependencies =[]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|ext| load ext}