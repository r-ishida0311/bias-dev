class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :role
      t.timestamps
    end
    add_reference :roles, :department, foreign_key: true
  end
end
