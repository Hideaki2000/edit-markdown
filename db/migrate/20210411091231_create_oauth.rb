class CreateOauth < ActiveRecord::Migration[6.1]
  def change
    create_table :oauths do |t|
      t.string :email,            null: false
      t.string :password_digest, null:false
      t.string :account_type, null:false
      t.timestamps                null: false
    end
    add_index :oauths, :email, unique: true
  end
end
