# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "navGATE"
  s.version = "0.1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Becker"]
  s.date = "2014-01-09"
  s.description = "Can create navigation from objects using the nav builder,from database tables or from a yaml file"
  s.email = "mbeckerwork@gmail.com"
  s.extra_rdoc_files = ["lib/navgate.rb", "lib/navgate/base.rb", "lib/navgate/builder.rb", "lib/navgate/main.rb", "lib/navgate/modules/navgatehelpers.rb", "lib/readme.rdoc"]
  s.files = ["LICENCE/GPL-2", "Manifest", "Rakefile", "config/build_menu.yml", "config/initializers/build_menu.rb", "init.rb", "lib/navgate.rb", "lib/navgate/base.rb", "lib/navgate/builder.rb", "lib/navgate/main.rb", "lib/navgate/modules/navgatehelpers.rb", "lib/readme.rdoc", "navGATE.gemspec", "readme.rdoc"]
  s.homepage = "https://github.com/Thermatix/navGATE"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "navGATE", "--main", "readme.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "navgate"
  s.rubygems_version = "2.0.6"
  s.summary = "Allows the easy creation of navigation with config files"
end
