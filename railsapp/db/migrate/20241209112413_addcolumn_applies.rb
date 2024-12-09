class AddcolumnApplies < ActiveRecord::Migration[7.1]
  def change
    add_column :applies, :boss1_id, :integer
  end
end
