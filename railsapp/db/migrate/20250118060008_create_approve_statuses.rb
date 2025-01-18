class CreateApproveStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :approve_statuses do |t|
      t.integer :approve_status
      t.timestamps
    end
    add_reference :approve_statuses, :apply, foreign_key: true
  end
end
