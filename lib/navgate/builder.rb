module NavGate
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
end