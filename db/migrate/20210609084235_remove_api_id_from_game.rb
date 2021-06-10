class RemoveApiIdFromGame < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :api_id, :interger
  end
end
