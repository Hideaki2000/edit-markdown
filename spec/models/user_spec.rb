# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  account_type     :string(255)
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'
RSpec.describe Oauth, type: :model do
  before(:example) do
    @user = Oauth.new(
      email: 'hogehoge@gmail.com',
      password: 'Hogehoge1',
      password_confirmation: 'Hogehoge1',
      account_type: 'basic_user'
    )
  end
  context 'アカウント作成時' do
    example '正常なアカウント登録' do
      bool = @user.save
      expect(bool).to eq(true)
    end
    example 'password_confirmationとpasswordの値が違う' do
      @user.password_confirmation = 'hoge'
      @user.save
      expect(@user.errors.messages[:password][0]).to eq(Constants::Oauth::Validation::Password::DO_NOT_CHANGE)
    end
    example 'passwordが不正' do
      @user.password = 'hoge'
      @user.password_confirmation = 'hoge'
      @user.save
      expect(@user.errors.messages[:password][0]).to eq(Constants::Oauth::Validation::Password::FORMAT)
    end
    example '同じアカウントを作らない' do
      @user.save
      @user = Oauth.new(
        email: 'hogehoge@gmail.com',
        password: 'Hogehoge1',
        password_confirmation: 'Hogehoge1'
      )
      @user.save
      expect(@user.errors.messages[:email][0]).to eq(Constants::Oauth::Validation::Email::UNIQUE)
    end

    example 'アカウントタイプのフォーマットがあっているか' do
      @user.save
      @user = Oauth.find_by(email: 'hogehoge@gmail.com')
      @user.account_type = 'jifjie'
      @user.save
      expect(@user.errors.messages[:account_type][0]).to eq(Constants::Oauth::Validation::AccountType::DID_NOT_CHANGE)
    end
  end
  describe 'アカウントの更新について' do
    example 'account_typeの変更不可' do
      @user.save
      @user = Oauth.find_by(email: 'hogehoge@gmail.com')
      @user.update(account_type: Constants::Oauth::AccountType::ADMIN)
      expect(@user.errors.messages[:account_type][0]).to eq(Constants::Oauth::Validation::AccountType::DID_NOT_CHANGE)
    end
    context 'emailの変更について' do
      example '正常' do
        @user.save
        @user = Oauth.find_by(email: 'hogehoge@gmail.com')
        @user.update(email: 'hogehoge1@gmail.com')
        @user.save
        expect(@user.valid?).to eq(true)
      end

      example 'formatが違う' do
        @user.save
        @user = Oauth.find_by(email: 'hogehoge@gmail.com')
        @user.update(email: 'hfkefefijei')
        @user.save
        expect(@user.errors.messages[:email][0]).to eq(Constants::Oauth::Validation::Email::FORMAT)
      end
    end
  end
  context 'AccountTypeのextendsが上手くか' do
    example 'アカウントを見つけた時に正常にextendsされるのか' do
      @user.save
      @user = Oauth.find_by(email: 'hogehoge@gmail.com')
      expect(@user.provider_name).to eq('line')
    end
  end
  describe 'ログインの時について' do
    context 'authenticateメソッドの動きが上手く動いているのか' do
      example '通常のログイン時' do
        @user.save
        @user = Oauth.find_by(email: @user.email)
        confirmed_user = @user.authenticate('Hogehoge1')
        expect(@user.email).to eq(confirmed_user.email)
      end

      example 'passwordを間違えた時' do
        @user.save
        expect(@user.authenticate('Hogehoge2')).to eq(false)
      end
    end
  end
end
