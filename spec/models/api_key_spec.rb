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
# require 'rails_helper'

# RSpec.describe ApiKey, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
