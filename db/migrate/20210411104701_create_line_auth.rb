class CreateLineAuth < ActiveRecord::Migration[6.1]
  def change
    create_table :line_auths do |t|
      t.references :oauth, null: false
      t.string :provider, :uid, null: false
      t.timestamps              null: false
    end
    add_index :line_auths, [:provider, :uid]
  end
end
