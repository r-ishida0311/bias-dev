class RemoveColumnY < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :apply_status_id
  end
end
