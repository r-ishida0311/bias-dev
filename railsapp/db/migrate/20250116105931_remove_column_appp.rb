class RemoveColumnAppp < ActiveRecord::Migration[7.1]
  def change
    
    add_reference :divisions, :apply, foreign_key: true
  end
end
