class AddColumnMail < ActiveRecord::Migration[7.1]
  def change

    add_column :applies, :emp_email, :string
  end
end
