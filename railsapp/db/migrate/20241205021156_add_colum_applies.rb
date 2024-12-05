class AddColumApplies < ActiveRecord::Migration[7.1]
  def change
    add_column :applies, :boss1_id ,:integer
    add_column :applies, :boss2_id ,:integer
    add_column :applies, :boss3_id ,:integer
  end
end
