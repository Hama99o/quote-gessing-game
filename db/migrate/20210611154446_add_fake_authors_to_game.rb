class AddFakeAuthorsToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :fake_authors, :string
  end
end
