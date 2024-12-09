class RemovecolumnApplies < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :boss1_id
    remove_column :applies, :boss2_id
    remove_column :applies, :boss3_id
  end
end
