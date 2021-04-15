module Confirmation::AccountType::Company
  extend ActiveSupport::Concern
  included do
    has_one :authentication
  end
  
  class_methods do
    def extend?
      true
    end
  end
end