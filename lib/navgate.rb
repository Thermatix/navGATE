require 'navgate/base'
require 'navgate/navgatehelpers'
require 'awesome_print'
class Navgate
  class Builder < Base

    def render_it_with(options,selected)
      options_to_render = ""
      if self.css_class
        if options && options[:class]
          options[:class] = self.css_class
        else
          options = { class: self.css_class}
        end
      end
      if options
        options.each do |key,value|
          options_to_render += ("#{key}='#{value}'" + " ") unless ignoring key
        end
      end
      style = styling(options)
      @text_to_render = ""
      selected.gsub!('/',"")
      if !self.by_id
        self.selection.each do |select|
          @text_to_render += select_text_for(select,selected,options[:wrap],options_to_render,style)
        end
      else
        self.selection.each_with_index do |select,i|
          @text_to_render += select_text_for(select,selected,options[:wrap],options_to_render,style,i)
        end
      end
      @text_to_render
    end

    private
      def select_text_for select, selected, wrap, options_to_render, style, id=nil
        return_temp = ""
        wrap_with(wrap) do
          if select != id &&  select != selected
            return_temp = generate_text(select,options_to_render,style,id)
          else
            if self.css_selected
              if options_to_render =~ /class='.*'/
                temp = options_to_render.gsub(/class='.*'/,"class='#{self.css_selected}'")
                return_temp = generate_text(select,temp,style,id)
              else
                temp = options_to_render + "class='#{self.css_selected}'"
                return_temp = generate_text(select,temp,style,id)
              end#select which version to use
            else
              return_temp = ""
            end #render nothing or css_selected
          end #for select if
        end #for wrap method
        return_temp
      end #for method
      def generate_text(select,options_to_render,style,id = nil)
        "<a href=\"#{path_for(id || select)}\" #{options_to_render}>#{select.gsub('_'," ")}</a>#{style}"
      end
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
        if self.prefix
          return "/#{self.prefix}/#{link_to.downcase}"
        else
          return "/#{link_to.downcase}"
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

  attr_accessor :controllers, :navs, :ignoring

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



  def render_nav selection, controller, options
    if !ignoring.include?(selection)
      nav = nav_cache(controller.split('/').last).render_it_with(options,selection).html_safe
      nav
    else
      nil
    end
  end

  def select selection, controller
    if !ignoring.include?(selection)
      if selection
         selection
      else
         nav_cache(controller.split('/').last).default.to_s
      end
    else
       nil
    end
  end

  private

    def nav_cache controller
      if @selected_nav
        if @selected_nav.controller.is_a?(Array)
          return @selected_nav if @selected_nav.controller.include?(controller)
        else
          return @selected_nav unless @selected_nav.controller != controller
        end
        @selected_nav = nil
        nav_cache(controller)
      else
        @selected_nav ||= select_nav(controller)
      end
    end

    def select_nav controller
      nav_to_return = nil
      self.navs.each do |nav|
        if nav.controller.is_a?(String)
          nav_to_return = nav if (nav.controller) == controller
        elsif nav.controller.is_a?(Array)
          nav_to_return = nav if nav.controller.include?(controller)
        else
          raise TypeError, "expecting nav.controller to be a String or an Array, got #{nav.controller.class} "
        end
      end
      nav_to_return ?  (return nav_to_return) : (raise ArgumentError, "No matching controllers for #{controller}")
    end

    def not_bad_type? navs
      navs.is_a?(String) || navs.map{ |n| n.is_a?(Navgate::Builder)}.any?
    end
end