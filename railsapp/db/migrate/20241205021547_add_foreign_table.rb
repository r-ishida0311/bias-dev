class AddForeignTable < ActiveRecord::Migration[7.1]
  def change
    change_column :bosses, :id, :integer
    add_foreign_key :applies, :bosses, column: :boss1_id, on_delete: :nullify
    add_foreign_key :applies, :bosses, column: :boss2_id, on_delete: :nullify
    add_foreign_key :applies, :bosses, column: :boss3_id, on_delete: :nullify
  end
end
