require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  describe '新しいアカウントを作る' do
    before(:example) do
      @user = { confirmation_user: {
        email: 'hogehoge@gmail.com',
        password: 'Hogehoge1',
        password_confirmation: 'Hogehoge1'
      } }
    end
    context '正常なアカウント登録' do
      example '正常にアカウントを作ることができるか' do
        post admin_users_path, params: @user
        expect(Confirmation::User.exists?(email: 'hogehoge@gmail.com')).to eq(true)
      end
    end
  end
end
