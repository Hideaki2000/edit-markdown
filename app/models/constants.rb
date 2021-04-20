# 定数はここに入れること
module Constants
  WEEKS = %w[
    月 火 水 木 金 土 日
  ].freeze

  module Oauth
    module AccountType
      BASIC_USER = 'basic_user'.freeze
      CMS_USER = 'cms_user'.freeze
      ADMIN = 'admin'.freeze
      ACCOUNT_TYPES = %w[
        basic_user cms_user admin
      ].freeze
    end
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{6,12}\z/
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    module Validation
      module Email
        PRESENCE = 'メールが存在していません'.freeze
        FORMAT = 'メールのフォーマットが違います'.freeze
        UNIQUE = 'メールがすでに存在しています'.freeze
        DO_NOT_CHANGE = 'メールアドレスは変更できません'.freeze
      end

      module Password
        PRESENCE = 'パスワードが存在していません'.freeze
        DO_NOT_CHANGE = 'パスワードと確認用パスワードが一致しません'.freeze
        FORMAT = 'パスワードは半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります'.freeze
      end

      module AccountType
        PRESENCE = 'AcoountTypeが指定されてません'.freeze
        DID_NOT_CHANGE = 'AccountTypeは変更できません'.freeze
        FORMAT = 'AccountTypeのフォーマットが違います'.freeze
      end
    end
  end
end
