class RemoveColumnDep < ActiveRecord::Migration[7.1]
  def change
    remove_column :departments, :role1
    remove_column :departments, :role2
    remove_column :departments, :role3
    remove_column :departments, :role4
    remove_column :departments, :role5
    remove_column :departments, :role6
    remove_column :departments, :role7
    remove_column :departments, :role8
    remove_column :departments, :role9
    remove_column :departments, :role10
  end
end
