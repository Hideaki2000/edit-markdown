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
module Confirmation
  class User < ApplicationRecord
    # relationship
    has_many :api_key
    # this class is for authentication
    authenticates_with_sorcery!
    # attribute
    attribute :password_confirmation
    # after_initialize
    after_initialize do
      case account_type
      when Constants::User::AccountType::BASIC_USER
        extend Confirmation::AccountType::BasicUser
      when Constants::User::AccountType::CMS_USER
        extend Confirmation::AccountType::Company
      when Constants::User::AccountType::ADMIN
        extend Confirmation::AccountType::Admin
      else
        errors.add(:account_type, { code: 120, message: 'not include account_type' })
      end
    end
    # define the function for authentication
    def self.logged_in?(access_token)
      api_key = Confirmation::ApiKey.find_by(access_token: access_token)
      if !api_key || !api_key.before_expired? || !api_key.active
        false
      else
        find_by(id: api_key.user_id)
      end
    end

    def activate
      if api_key
        unless api_key.active
          api_key.set_active
          api_key.save
        end
        unless api_key.before_expired?
          api_key.set_expiration
          api_key.save
        end
        api_key
      else
        Confirmation::ApiKey.create(user_id: id).access_token
      end
    end

    def inactivate
      api_key.active = false
      api_key.save
    end

    private

    def api_key
      @api_key ||= Confirmation::ApiKey.find_by_user_id(id)
    end

    # validation all times
    validate :is_email_has_property_appropriate_format
    validate :account_type_format
    # validation when create
    validate :is_email_has_property_appropriate_format, on: :create
    validate :is_email_unique, on: :create
    validate :password_has_properry_format, on: :create
    validate :password_did_not_match_confirmation, on: :create
    # validation when update
    validate :do_not_change_account_type, on: :update
    validate :do_not_change_email, on: :update
    # validation method
    # validation of email (error code 10*)

    def is_email_nil
      errors.add(:email, { code: 100, message: 'email is nil' }) if email.nil?
    end

    def is_email_has_property_appropriate_format
      email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      errors.add(:email, { code: 101, message: 'email is not appropriate format' }) unless Constants::VALID_EMAIL_REGEX === email
    end

    def is_email_unique
      errors.add(:email, { code: 102, message: 'email alreadey exist' }) if self.class.exists?(email: email)
    end

    def do_not_change_email
      errors.add(:account_type, { code: 103, message: 'email cannot change' }) if email_changed?
    end

    # validation of password (error code 11*)
    def password_has_properry_format
      password_regex = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{6,12}\z/
      unless password_regex === password
        errors.add(:password,
                   { code: 110, message: 'パスワードは半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります' })
      end
    end

    def password_did_not_match_confirmation
      if password != password_confirmation
        errors.add(:password,
                   { code: 111,
                     message: 'password did not match password_confirmation' })
      end
    end

    # validation of account_type(eror code 12*)
    def account_type_nil
      errors.add(:account_type, { code: 120, message: 'account type cannot be nil' }) if account_type.nil?
    end

    def account_type_format
      unless Constants::User::AccountType::ACCOUNT_TYPES.include?(account_type)
        errors.add(:account_type,
                   { code: 121, message: 'invalid account type' })
      end
    end

    def do_not_change_account_type
      errors.add(:account_type, { code: 122, message: 'account_type cannot change' }) if account_type_changed?
    end
  end
end
