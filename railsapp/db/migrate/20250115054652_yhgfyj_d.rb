class YhgfyjD < ActiveRecord::Migration[7.1]
  def change
    remove_column :apply_statuses, :apply_id
    add_reference :apply_statuses, :apply, foreign_key: true
  end
end
