class ApplicationController < ActionController::Base
  protect_from_forgery
  include ExtAction::Base

end
