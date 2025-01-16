class RemoveColumnAp < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :sk_comment
    
  end
end
