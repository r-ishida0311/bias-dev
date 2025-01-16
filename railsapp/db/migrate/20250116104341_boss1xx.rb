class Boss1xx < ActiveRecord::Migration[7.1]
  def change
    remove_column :boss1s, :apply_id
    add_reference :boss1s, :apply, foreign_key: true
  end
end
