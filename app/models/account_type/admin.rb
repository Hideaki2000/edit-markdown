# このmoduleの説明
# Oauthで使われる
# Oauthが基本的な認証のロジックを担当する。しかしbasic_userやcms_userなどの細かいログインのロジックの違いをmoduleによって解決する

module AccountType
  module Admin
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
end
