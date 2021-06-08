class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.string :quote
      t.string :author
      t.string :fake_author
      t.integer :api_id

      t.timestamps
    end
  end
end
