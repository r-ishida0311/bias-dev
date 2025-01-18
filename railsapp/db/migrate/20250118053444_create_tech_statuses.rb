class CreateTechStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :tech_statuses do |t|
      t.string :tech_check_name
      t.integer :tech_status
      t.timestamps
    end
    add_reference :tech_statuses, :apply, foreign_key: true
  end
end
