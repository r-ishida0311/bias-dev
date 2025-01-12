class AddForeign < ActiveRecord::Migration[7.1]
  def change
    remove_column :apply_statuses, :apply_id
    add_column :apply_statuses, :apply_id, :bigint
    add_foreign_key :apply_statuses, :applies, column: :apply_id, on_delete: :cascade
  end
end
