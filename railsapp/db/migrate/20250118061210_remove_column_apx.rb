class RemoveColumnApx < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :tech_status
    remove_column :applies, :tech_check_name
    remove_column :applies, :approve_status
    remove_column :applies, :wg_comment
    remove_column :applies, :wg_comment_status
    remove_column :applies, :wg_reply_comment

    
  end
end
