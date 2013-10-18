module NavGateHelpers
  def make_menu
    @navgate = NAVGATE
    @selected ||= @navgate.select(params)
  end
  def render_navigation options = nil
    @navgate.render_nav(params, options)
  end

end

