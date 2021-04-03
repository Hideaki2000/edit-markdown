class SessionsController < ActionController::Base
  layout 'layouts/session_layout'
  protect_from_forgery

  def new
    @user = ::User.new
  end

  def create
    @user = ::User.find_by(email: session_params[:email])

    email_invalid and return unless @user.present?

    if @user&.authenticate(session_params[:password])
      cookies.permanent[:uid] = @user.uid
      redirect_to root_path, flash: { info: 'ログインに成功しました。' }
    else
      password_invalid
    end
  end

  def destroy
    cookies.delete :uid
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
    @user = ::User.new
    flash.now[:danger] = 'メールアドレスが間違っています。'
    render :new
  end

  def password_invalid
    @user = ::User.new
    flash.now[:danger] = 'メールアドレスが間違っています。'
    render :new
  end
end