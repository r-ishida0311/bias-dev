class ChangeColumApplies < ActiveRecord::Migration[7.1]
  def change
    rename_column :bosses, :boss1_no, :boss_no
    rename_column :bosses, :boss1_name, :boss_name
    rename_column :bosses, :boss1_status, :boss_status
    rename_column :bosses, :email, :boss_email
  end
end
