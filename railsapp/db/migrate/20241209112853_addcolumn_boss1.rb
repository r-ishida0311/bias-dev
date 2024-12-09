class AddcolumnBoss1 < ActiveRecord::Migration[7.1]
  def change
    add_column :boss1, :boss_depart, :string
  end
end
