# == Schema Information
#
# Table name: users
#
#  id                                :bigint           not null, primary key
#  email(メールアドレス)             :string(255)      default(""), not null
#  is_mail_confirm(メール確認フラグ) :boolean          default(FALSE), not null
#  name(名前)                        :string(255)      default(""), not null
#  password_digest(パスワード)       :string(255)      default(""), not null
#  uid(ユニークID)                   :string(255)      default(""), not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_uid    (uid) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :uid, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: Constants::VALID_EMAIL_REGEX }, length: { maximum: 255 }
  validates :is_mail_confirm, inclusion: { in: [true, false] }
end
