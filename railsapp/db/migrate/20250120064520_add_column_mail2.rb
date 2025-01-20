class AddColumnMail2 < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :login_email, :string
  end
end
