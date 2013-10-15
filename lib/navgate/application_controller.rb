
class ApplicationController < ActionController::Base
  before_filter :make_menu
  helper_method :render_navigation
  def make_menu
    @navgate = NAVGATE
    @selected ||= @navgate.select(params)
  end
  def render_navigation options = nil
    @navgate.render_nav(params, options)
  end
end

