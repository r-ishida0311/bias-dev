class RolesAdd < ActiveRecord::Migration[7.1]
  def change
    rename_column :roles, :role, :role1
    add_column :roles, :role2, :string
    add_column :roles, :role3, :string
    add_column :roles, :role4, :string
    add_column :roles, :role5, :string
    add_column :roles, :role6, :string
    add_column :roles, :role7, :string
    add_column :roles, :role8, :string
    add_column :roles, :role9, :string
    add_column :roles, :role10, :string
  end
end
