class AddChosenAuthorToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :chosen_author, :text
  end
end
