class RemoveEmailFromGuestUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :guest_users, :email, :string
  end
end
