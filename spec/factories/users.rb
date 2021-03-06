# == Schema Information
#
# Table name: users
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
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :basic_user, class: Oauth do
    sequence(:email) { |n| "test-basic-user#{n}@example.com" }
    password { 'Password1' }
    password_confirmation { 'Password1' }
    account_type { 'basic' }
  end

  factory :company, class: Oauth do
    sequence(:email) { |n| "test-company#{n}@example.com" }
    password { 'Password1' }
    password_confirmation { 'Password1' }
    account_type { 'company' }
  end

  factory :admin, class: Oauth do
    sequence(:email) { |n| "test-admin#{n}@example.com" }
    password { 'Password1' }
    password_confirmation { 'Password1' }
    account_type { 'admin' }
  end
end
