class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :ensured_sign_in
  include ::ApplicationHelper
  include Pundit

  def current_user
    unless defined?(@current_user)
      if access_token
        @current_user = Confirmation::User.logged_in?(access_token)
      else
        false
      end
    end
  end
  helper_method :current_user

  attr_writer :current_user

  # this method have to change in future
  def ensured_sign_in
    redirect_to new_admin_user_path unless current_user
  end

  def access_token
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
