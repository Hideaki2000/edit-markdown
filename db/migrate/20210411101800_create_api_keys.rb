class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.datetime :expire_at
      t.references :oauth
      t.boolean :active
      t.timestamps
    end
  end
end
