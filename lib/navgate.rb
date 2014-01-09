Dir[File.dirname(__FILE__) + '/navgate/modules/*.rb'].each {|file| require file }
require 'navgate/base'
require 'navgate/builder'
require 'awesome_print'

module NavGate

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Congiruration.new
    yield(configuration)
    self.configuration.post_setup
  end

  class Configuration
    attr_accessor :controllers, :navs, :ignoring

    def initialize
      self.controllers = Rails.application.routes.routes.map do |route|
        route.defaults[:controller]
      end.uniq.compact

    end

    def post_setup
      raise TypeError, "Expected Navgate:Builder or string" unless not_bad_type?(self.navs)
      if self.navs.is_a?(String)
        setup = YAML.load_file(self.navs)
        temp = []
        setup.each do |menu|
          temp.push(Navgate::Builder.new do |options|
                      options[:selection] = menu[1]['selection'].split(" ")
                      options[:default] = menu[1]['default'] || nill
                      options[:prefix] = menu[1]['prefix'] || nil
                      options[:controller] = menu[1]['controller'] || nil
                      options[:by_id] = menu[1]['by_id'] || nil
                      options[:css_class] = menu[1]['css_class'] || nil
                    end
                  )
        end
        self.navs = temp
      end
      self.ignoring ||= [""]
    end

    private

      def not_bad_type? navs
        navs.is_a?(String) || navs.map{ |n| n.is_a?(NavGate::Builder)}.any?
      end

  end


end