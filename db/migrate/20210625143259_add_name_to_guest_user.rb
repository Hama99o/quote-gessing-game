class AddNameToGuestUser < ActiveRecord::Migration[6.1]
  def change
    add_column :guest_users, :name, :string
  end
end
