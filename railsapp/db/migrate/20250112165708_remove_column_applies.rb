class RemoveColumnApplies < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies,  :apply_status
  end
end
