class RemovecolumnBosses < ActiveRecord::Migration[7.1]
  def change
    remove_column :bosses, :apply_id
  end
end
