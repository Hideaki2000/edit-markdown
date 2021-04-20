class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.string :access_token, null: false
      t.datetime :expire_at, null: false
      t.references :oauth, null: false
      t.boolean :active, null: false
      t.timestamps
    end
  end
end
