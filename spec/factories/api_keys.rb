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
FactoryBot.define do
  factory :api_key do
    access_token { "MyString" }
    expire_at { "2021-04-11 10:18:03" }
    references { "" }
    active { "" }
  end
end
