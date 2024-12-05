class DropTableBoss < ActiveRecord::Migration[7.1]
  def change
    drop_table :boss2s
    drop_table :boss3s
    rename_table :boss1s, :bosses
  end
end
