class RemoveColumn2 < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies,  :apply_update_date
    remove_column :applies,  :tech_update_date
  end
end
