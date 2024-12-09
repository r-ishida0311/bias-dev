class RenameTableBoss1 < ActiveRecord::Migration[7.1]
  def change
    rename_table :boss1, :boss1s
  end
end
