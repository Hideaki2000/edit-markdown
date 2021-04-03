class User < ApplicationRecord
  has_secure_password

  validates :uid, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: Constants::VALID_EMAIL_REGEX }, length: { maximum: 255 }
  validates :is_mail_confirm, inclusion: { in: [true, false] }
end
