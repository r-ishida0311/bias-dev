class Yhgfyj < ActiveRecord::Migration[7.1]
  def change
    remove_column :apply_statuses, :apply_id
  end
end
