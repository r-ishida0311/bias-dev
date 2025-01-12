class RemoveColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :boss_update_date
   remove_column :applies,  :approve_update_date
    remove_column :applies,  :wg_comment_update_date
   remove_column :applies,  :wg_reply_comment_update_date
  end
end
