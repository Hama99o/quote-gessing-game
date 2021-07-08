class AddPersonToGame < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :person, polymorphic: true, null: false
  end
end
