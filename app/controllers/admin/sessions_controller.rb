module Admin
  class SessionsController < Admin::ApplicationController
    layout 'layouts/session_layout'
    protect_from_forgery
    skip_before_action :ensured_sign_in, only: %i[new create]

    def new
      @user = Oauth.new
    end

    def create
      @user = Oauth.find_by(session_params[:email])
      # ユーザーが存在してないかった時
      email_invalid and return unless @user.present?

      @user = @user.authenticate(session_params[:password])
      cookies.permanent[:access_token] = @user.activate
      redirect_to admin_home_index_path, flash: { info: 'ログインに成功しました。' }
    end

    def destroy
      cookies.delete :access_token
      redirect_to new_session_path
    end

    private

    def session_params
      params.require(:user).permit(
        :email,
        :password
      )
    end

    def email_invalid
      @user = Oauth.new
      flash.now[:danger] = 'メールアドレスが間違っています。'
      render :new
    end

    def password_invalid
      @user = Oauth.new
      flash.now[:danger] = 'メールアドレスが間違っています。'
      render :new
    end
  end
end
