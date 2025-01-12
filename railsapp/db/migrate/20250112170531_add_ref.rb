class AddRef < ActiveRecord::Migration[7.1]
  def change
    add_column :apply_statuses, :apply_id, :integer
  end
end
