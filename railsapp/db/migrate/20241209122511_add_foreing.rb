class AddForeing < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :applies, :boss1s, column: :boss1_id, on_delete: :nullify
  end
end
