class RemoveFakeAuthorFromGame < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :fake_author, :string
  end
end
