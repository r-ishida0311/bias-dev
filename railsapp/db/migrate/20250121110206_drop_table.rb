class DropTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :add_deps
  end
end
