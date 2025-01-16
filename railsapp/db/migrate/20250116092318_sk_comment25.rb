class SkComment25 < ActiveRecord::Migration[7.1]
  def change
    add_column :sk_comments, :apply_id, :integer
  end
end
