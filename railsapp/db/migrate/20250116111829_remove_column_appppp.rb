class RemoveColumnAppppp < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :division_id
  end
end
