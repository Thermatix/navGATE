require 'navgate/base'
require 'navgate/application_controller'
require 'navgate/application_helper'
class Navgate
  class Builder < Base

    def render_it_with(options)
      options_to_render = ""
      options[:class] = "'#{self.css_class}'" if self.css_class
      if options
        options.each do |key,value|
          ap value
          options_to_render += ("#{key}=#{value}" + " ") unless ignoring key
          ap options_to_render
        end
      end
      style = styling(options)
      @text_to_render = ""
      if !self.by_id
        self.selection.each do |select|
          wrap_with options[:wrap] do
            @text_to_render += "<a href=\"#{path_for(select)}\" #{options_to_render}>#{select.gsub('_'," ")}</a>#{style}"
          end
        end
      else
        self.selection.each_with_index do |select,i|
          wrap_with options[:wrap] do
            @text_to_render += "<a href=\"#{path_for(self.by_id[i])}\" #{options_to_render}>#{select.gsub('_'," ")}</a>#{style}"
          end
        end
      end
      @text_to_render
    end



    private
      def wrap_with tag, &block
        if tag.is_a?(Array)
          tag_beggining = "#{tag[0]} class='#{tag[1]}'"
          tag_end = tag[0]
        else
          tag_beggining = tag
          tag_end = tag
        end
        if tag
          @text_to_render += "<#{tag_beggining}>"
            yield
          @text_to_render += "</#{tag_end}>"
        else
          yield
        end
      end

      def path_for link_to
        if self.namespace
          return "/#{self.namespace}/#{link_to}"
        elsif self.prefix
          return "/#{self.prefix}/#{link_to}"
        else
          return "/#{link_to}"
        end
      end

      def styling options
        if options
          return "<br>" if options[:styling] == :vertical
          return options[:styling] if options[:styling]
        end
        " "
      end

      def ignoring k
         [:styling,:wrap].include?(k)
      end

  end

  attr_accessor :controllers, :navs

  def initialize
    self.controllers = Rails.application.routes.routes.map do |route|
      route.defaults[:controller]
    end.uniq.compact
    yield(self)
    raise TypeError, "Expected Navgate:Builder or string" unless not_bad_type?(self.navs)
    if self.navs.is_a?(String)
      setup = YAML.load_file(self.navs)
      temp = []
      setup.each do |menu|
        temp.push(Navgate::Builder.new do |options|
                    options[:selection] = menu[1]['selection'].split(" ")
                    options[:default] = menu[1]['default'] || nill
                    options[:namespace] = menu[1]['namespace'] || nil
                    options[:prefix] = menu[1]['prefix'] || nil
                    options[:controller] = menu[1]['controller'] || nil
                    options[:by_id] = menu[1]['by_id'] || nil
                    options[:css_class] = menu[1]['css_class'] || nil
                  end
                )
      end
      self.navs = temp
    end
  end



  def render_nav params, options
    select_nav(params[:controller]).render_it_with(options).html_safe
  end

  def select params
    nav = select_nav(params[:controller])
    return params[:selection] ? params[:selection] : nav.default
  end
  private
    def select_nav controller
      self.navs.each do |nav|
          return nav if nav.controller == controller
      end
    end

    def not_bad_type? navs
      navs.is_a?(String) || navs.map{ |n| n.is_a?(Navgate::Builder)}.any?
    end
end