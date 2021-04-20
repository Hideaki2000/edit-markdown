# == Schema Information
#
# Table name: oauths
#
#  id              :bigint           not null, primary key
#  account_type    :string(255)
#  email           :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_oauths_on_email  (email) UNIQUE
#
# このクラスの説明
# 基本的なパスワードの認証

class Oauth < ApplicationRecord
  # relationship
  has_one :api_key
  has_secure_password
  # attribute
  attribute :password_confirmation
  # after_initialize 認証の際にaccount_typeによる、細かい処理の違いをここで実装する
  after_initialize do
    case account_type
    when Constants::Oauth::AccountType::BASIC_USER
      extend AccountType::BasicUser
    when Constants::Oauth::AccountType::CMS_USER
      extend AccountType::Company
    when Constants::Oauth::AccountType::ADMIN
      extend AccountType::Admin
    end
  end
  # define the function for authentication
  def self.logged_in?(access_token)
    api_key = ApiKey.find_by(access_token: access_token)
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
      ApiKey.create(user_id: id).access_token
    end
  end

  def inactivate
    api_key.active = false
    api_key.save
  end

  private

  def api_key
    @api_key ||= ApiKey.find_by_user_id(id)
  end

  # validation all times
  validates :email, presence: true
  validate :email_has_property_appropriate_format?
  validates :account_type, presence: true
  # validation when create
  validate :email_unique?, on: :create
  validate :password_has_properry_format, on: :create
  validate :password_did_not_match_confirmation, on: :create
  # validation when update
  validate :do_not_change_account_type, on: :update
  # validation method
  # validation of email (error code 10*)
  def email_has_property_appropriate_format?
    errors.add(:email, message: Constants::Oauth::Validation::Email::FORMAT) unless Constants::Oauth::VALID_EMAIL_REGEX === email
  end

  def email_unique?
    errors.add(:email, Constants::Oauth::Validation::Email::UNIQUE) if self.class.exists?(email: email)
  end

  def do_not_change_email
    errors.add(:email, Constants::Oauth::Validation::Email::DO_NOT_CHANGE) if email_changed?
  end

  # validation of password (error code 11*)
  def password_has_properry_format
    errors.add(:password, message: Constants::Oauth::Validation::Password::FORMAT) unless Constants::Oauth::PASSWORD_REGEX.match?(password)
  end

  def password_did_not_match_confirmation
    errors.add(:password, message: Constants::Oauth::Validation::Password::DO_NOT_CHANGE) if password != password_confirmation
  end

  # validation of account_type(eror code 12*)
  def account_type_nil
    errors.add(:account_type, message: Constants::Oauth::Validation::AccountType::PRESENCE) if account_type.nil?
  end

  def account_type_format
    unless Constants::Oauth::AccountType::ACCOUNT_TYPES.include?(account_type)
      errors.add(:account_type, message: Constants::Oauth::Validation::AccountType::FORMAT)
    end
  end

  def do_not_change_account_type
    errors.add(:account_type, Constants::Oauth::Validation::AccountType::DID_NOT_CHANGE) if account_type_changed?
  end
end
