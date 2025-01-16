class SkComment2343 < ActiveRecord::Migration[7.1]
  def change
    remove_column :sk_comments, :apply_id
    add_reference :sk_comments, :apply, foreign_key: true
  end
end
