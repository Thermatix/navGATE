module NavGate
  class Navigation
    def self.select selection, controller
      split_controller = controller.split('/').last
      if selection
         selection
      else
        if config.ignoring.include?(split_controller)
          nil
        else
         nav_cache(split_controller).default.to_s
         end
      end
    end

    def self.render_nav selection, controller, options
      split_controller = controller.split('/').last
      if config.ignoring.include?(split_controller)
        nil
      else
        nav = nav_cache(split_controller).render_it_with(options,selection).html_safe
        nav
      end
    end

    private

      def self.config
        NavGate.configuration
      end

      def self.nav_cache controller
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

      def self.select_nav controller
        nav_to_return = nil
        config.navs.each do |nav|
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
  end
end