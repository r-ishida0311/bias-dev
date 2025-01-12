class ChnageBoss < ActiveRecord::Migration[7.1]
  def change
    change_column :boss1s, :boss_no, :string, limit: 4
  end
end
