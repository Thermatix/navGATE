module NavGateHelpers
  def make_menu
    @navgate = NAVGATE
    @selected ||= @navgate.select(params) if params[:selection]
  end
  def render_navigation options = nil
    @navgate.render_nav(params, options)
  end

end

