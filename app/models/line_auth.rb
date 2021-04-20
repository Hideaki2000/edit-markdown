# == Schema Information
#
# Table name: line_auths
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
#  index_line_auths_on_oauth_id          (oauth_id)
#  index_line_auths_on_provider_and_uid  (provider,uid)
#
class LineAuth < ApplicationRecord
  belongs_to :oauth
end
