class AddScoreToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :score, :boolean
  end
end
