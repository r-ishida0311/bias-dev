class AddAppliesForeign < ActiveRecord::Migration[7.1]
  def change
    add_reference :applies, :role, foreign_key: true
  end
end
