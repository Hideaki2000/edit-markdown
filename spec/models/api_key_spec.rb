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
#  oauth_id     :bigint
#
# Indexes
#
#  index_api_keys_on_oauth_id  (oauth_id)
#

# RSpec.describe ApiKey, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
