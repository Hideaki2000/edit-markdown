class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :ensured_sign_in
  include ::ApplicationHelper
  include Pundit

  def current_user
    @current_user ||= ::User.find_by(uid: cookies[:uid])
  end
  helper_method :current_user

  def ensured_sign_in
    redirect_to new_session_path and return unless current_user.present?
  end
end
