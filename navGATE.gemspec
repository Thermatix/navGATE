# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "navGATE"
  s.version = "0.1.03"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Becker"]
  s.date = "2013-10-15"
  s.description = "Allows the easy creation of menus with config files"
  s.email = "mbeckerwork@gmail.com"
  s.extra_rdoc_files = ["lib/navgate.rb", "lib/navgate/base.rb"]
  s.files = ["Manifest", "Rakefile", "app/controller/application_controller.rb", "app/helpers/application_helper.rb", "config/build_menu.yml", "config/initializers/build_menu.rb", "init.rb", "lib/navgate.rb", "lib/navgate/base.rb", "navGATE.gemspec", "readme.rdoc"]
  s.homepage = "https://github.com/Thermatix/navGATE"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "navGATE", "--main", "readme.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "navgate"
  s.rubygems_version = "2.0.6"
  s.summary = "Allows the easy creation of menus with config files"
end
