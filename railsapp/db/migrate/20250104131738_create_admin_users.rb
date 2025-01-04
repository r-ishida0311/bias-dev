class CreateAdminUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_users do |t|
      t.integer :emp_no
      t.string :emp_name
      t.integer :tech_flag
      t.integer :wg_flag
      t.integer :sys_flag
      t.timestamps
    end
  end
end
