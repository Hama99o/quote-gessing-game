class AddHasGuessedToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :has_guessed, :boolean
  end
end
