module Confirmation::AccountType::BasicUser
  extend ActiveSupport::Concern
  included do
    has_one :authentication
  end

  def provider_name
    'line'
  end
  
  class_methods do
    def extend?
      true
    end
  end
end
