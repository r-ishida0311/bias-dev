class RenameTableBosses < ActiveRecord::Migration[7.1]
  def change
    rename_table :bosses, :boss1
  end
end
