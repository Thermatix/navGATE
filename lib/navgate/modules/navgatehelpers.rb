module NavGate
  module NavGateHelpers
    def NavGateHelpers.included(mod)
      if Module.const_get("Rails").is_a?(Module).inspect
        #with rails
        def make_menu
          @navgate = NAVGATE
          @selected ||= @navgate.select(params[:selection], params[:controller])
        end
        def render_navigation options = nil
          @navgate.render_nav((params[:selection]||request.fullpath), params[:controller], options )
        end
      else
        #without rails
        def make_menu selection, controller
          @navgate = NAVGATE
          @selected ||= @navgate.select(selection, controller)
        end
        def render_navigation controller, options = nil
          @navgate.render_nav( @selected , controller, options )
        end
      end
    end
  end
end

