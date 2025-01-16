class CreateSkComment2s < ActiveRecord::Migration[7.1]
  def change
    create_table :sk_comment2s do |t|

      t.timestamps
    end
  end
end
