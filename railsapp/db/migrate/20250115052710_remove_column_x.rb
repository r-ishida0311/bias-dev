class RemoveColumnX < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :boss1_id
  end
end
