class AddColumBoss < ActiveRecord::Migration[7.1]
  def change
    add_column :boss1s, :email, :string
    add_column :boss2s, :email, :string
    add_column :boss3s, :email, :string
  end
end
