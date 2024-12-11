class AddColumnApplies < ActiveRecord::Migration[7.1]
  def change
    add_column :applies, :year, :integer
  end
end
