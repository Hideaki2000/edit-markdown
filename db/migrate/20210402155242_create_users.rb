class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, comment: 'ユーザー' do |t|
      t.string :name, limit: 255, null: false, default: '', comment: '名前'
      t.string :email, limit: 255, null: false, default: '', comment: 'メールアドレス'
      t.string :password_digest, limit: 255, null: false, default: '', comment: 'パスワード'
      t.string :uid, limit: 255, null: false, default: '', comment: 'ユニークID'
      t.boolean :is_mail_confirm, null: false, default: false, comment: 'メール確認フラグ'

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :uid, unique: true
  end
end
