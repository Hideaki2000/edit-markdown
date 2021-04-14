module Confirmation
  module AccountType
    module BasicUser
      def self.included(klass)
        klass.has_one :authentication
      end

      # this method is for test
      def extend?
        true
      end

      def provider_name
        'line'
      end
    end
  end
end
