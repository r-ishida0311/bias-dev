class CreateTechReplyComments < ActiveRecord::Migration[7.1]
  def change
    create_table :tech_reply_comments do |t|
t.string :tech_reply_comment
      t.timestamps
    end
    add_reference :tech_reply_comments, :apply, foreign_key: true
  end
end
