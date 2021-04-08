# == Schema Information
#
# Table name: users
#
#  id                                :bigint           not null, primary key
#  email(メールアドレス)             :string(255)      default(""), not null
#  is_mail_confirm(メール確認フラグ) :boolean          default(FALSE), not null
#  name(名前)                        :string(255)      default(""), not null
#  password_digest(パスワード)       :string(255)      default(""), not null
#  uid(ユニークID)                   :string(255)      default(""), not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_uid    (uid) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }

    it { should allow_value(%w[true false]).for(:is_mail_confirm) }
  end

  context 'db' do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:uid).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

    it { should have_db_index(:uid) }
    it { should have_db_index(:email) }
  end
end
