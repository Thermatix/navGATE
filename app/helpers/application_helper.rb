module ApplicationHelper
  def render_navigation options = nil
    @navgate.render_nav(params, options)
  end
end
