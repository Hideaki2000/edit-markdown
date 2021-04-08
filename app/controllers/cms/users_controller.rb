module Cms
  class UsersController < ActionController::Base
    layout 'layouts/session_layout'
    protect_from_forgery

    def new; end
  end
end
