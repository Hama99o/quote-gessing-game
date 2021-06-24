class AddEmailToGuestUser < ActiveRecord::Migration[6.1]
  def change
    add_column :guest_users, :email, :string
  end
end
