
    class Admin::UsersController < Admin::ApplicationController
      layout 'layouts/session_layout'
      protect_from_forgery
      skip_before_action :ensured_sign_in, only: %i[new create]
      def new
        @user=Confirmation::User.new
      end
  
  
      def create
        params[:confirmation_user][:account_type]='admin'
        @user=Confirmation::User.new(user_params)
        if @user.valid?
          @user.save
          cookies.permanent[:access_token]=@user.activate
          redirect_to admin_home_index_path, flash: { info: 'ログインに成功しました。' }
        else
          redirect_to new_admin_user_path flash:{info: 'ログインに失敗しました'}
        end
        
      end
  
  
      private
      def user_params
        params.require(:confirmation_user).permit(:email,:password,:password_confirmation, :account_type)
      end
    end