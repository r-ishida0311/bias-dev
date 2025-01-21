class RemoveColumnAdddep < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :add_dep_id
  end
end
