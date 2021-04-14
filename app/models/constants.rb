# 定数はここに入れること
module Constants
  WEEKS = %w[
    月 火 水 木 金 土 日
  ].freeze

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  module User
    module AccountType
      BASIC_USER = 'basic_user'
      CMS_USER = 'cms_user'
      ADMIN = 'admin'
      ACCOUNT_TYPES = %w[
        basic_user cms_user admin
      ]
    end
  end
end
