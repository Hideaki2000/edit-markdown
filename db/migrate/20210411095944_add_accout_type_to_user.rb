class AddAccoutTypeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :account_type, :string
  end
end
