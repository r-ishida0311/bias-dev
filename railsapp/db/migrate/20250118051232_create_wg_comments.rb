class CreateWgComments < ActiveRecord::Migration[7.1]
  def change
    create_table :tech_comments do |t|
    t.string :tech_user
    t.string "tech_comment"
      t.timestamps
    end
    add_reference :tech_comments, :apply, foreign_key: true
  end
end
