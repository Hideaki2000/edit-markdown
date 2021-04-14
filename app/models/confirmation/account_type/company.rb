module Confirmation
  module AccountType
    module Company
      def self.included(klass)
        klass.has_one :authentication
      end
      # this method is for test
      def is_extend?
        true
      end
    end
  end
end
