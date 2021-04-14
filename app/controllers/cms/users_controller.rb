module Cms
  class UsersController < Cms::ApplicationController
    layout 'layouts/session_layout'
    protect_from_forgery
    skip_before_action :ensured_sign_in, only: %i[new create]
    def new; end

    def create
      params[:account_type] = 'cms_user'
      @user = Confirmation::User.new(user_params)
      cookie.permanent[:access_token] = @user.activate
      redirect_to
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :account_type)
    end
  end
end
