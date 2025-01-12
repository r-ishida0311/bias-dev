class CreateApplyStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :apply_statuses do |t|
      t.integer :apply_status, null: false
      t.timestamps
    end
  end
end
