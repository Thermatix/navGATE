
class ApplicationController < ActionController::Base
  before_filter :make_menu
  def make_menu
    @navgate = NAVGATE
    @selected ||= @navgate.select(params)
  end
end

