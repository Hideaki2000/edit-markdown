# == Schema Information
#
# Table name: authentications
#
#  id         :bigint           not null, primary key
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  oauth_id   :bigint           not null
#
# Indexes
#
#  index_authentications_on_oauth_id          (oauth_id)
#  index_authentications_on_provider_and_uid  (provider,uid)
#
module Confirmation
  class Authentication < ApplicationRecord
    belongs_to :user
  end
end
