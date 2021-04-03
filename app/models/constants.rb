module Constants
  WEEKS = %w[
    月 火 水 木 金 土 日
  ].freeze

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
end
