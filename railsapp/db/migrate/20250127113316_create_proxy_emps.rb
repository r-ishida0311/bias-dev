class CreateProxyEmps < ActiveRecord::Migration[7.1]
  def change
    create_table :proxy_emps do |t|
      t.string :proxy_emp_no
      t.string :proxy_emp_name
      t.string :proxy_emp_op
      t.timestamps
    end
    add_reference :proxy_emps, :apply, foreign_key: true
  end
end
