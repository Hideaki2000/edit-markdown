class Cms::SessionsController < Cms::ApplicationController
  layout 'layouts/session_layout'
  protect_from_forgery
  skip_before_action :ensured_sign_in, only: %i[new create]

  def new
    @user = Confirmation::User.new
  end

  def create
    @current_user=nil
    @user=Confirmation::User.authenticate(session_params[:email],session_params[:password])
    email_invalid and return unless @user.present?
    cookie.permanent[:access_token]=@user.activate
    redirect_to root_path, flash: { info: 'ログインに成功しました。' }
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
    @user = Confirmation::User.new
    flash.now[:danger] = 'メールアドレスが間違っています。'
    render :new
  end

  def password_invalid
    @user = Confirmation::User.new
    flash.now[:danger] = 'メールアドレスが間違っています。'
    render :new
  end
end
