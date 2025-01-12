class ChnageUser < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :login_ref_no, :string, limit: 4
  end
end
