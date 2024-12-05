class AddColumUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :groups, :text
  end
end
