class RemoveNameFromGuestUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :guest_users, :name, :string
  end
end
