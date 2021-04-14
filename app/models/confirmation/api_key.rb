# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint           not null, primary key
#  access_token :string(255)
#  active       :boolean
#  expire_at    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_api_keys_on_user_id  (user_id)
#
class Confirmation::ApiKey < ApplicationRecord
  before_create :generate_access_token, :set_expiration, :set_active
  belongs_to :user

  def before_expired?
    DateTime.now < self.expire_at
  end

  def set_active
    self.active = true
  end

  def set_expiration
    self.expire_at = DateTime.now + 7 * 60 * 60 * 24
  end

  
  private
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
