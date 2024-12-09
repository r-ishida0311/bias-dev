class AddApplyIdToBoss1s < ActiveRecord::Migration[7.1]
  def change
    add_column :boss1s, :apply_id, :integer
  end
end
