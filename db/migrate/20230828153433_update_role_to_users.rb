class UpdateRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :role, :string, default: 'user'
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
