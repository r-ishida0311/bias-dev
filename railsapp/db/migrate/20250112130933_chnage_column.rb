class ChnageColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :admin_users, :emp_no, :string, limit: 4
  end
end
