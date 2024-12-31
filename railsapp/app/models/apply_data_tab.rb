class ApplyDataTab < ApplicationRecord
  self.table_name='ApplyDataTab'
  self.primary_key = 'apply_data_id'
  has_many :FilesTab, foreign_key: :apply_data_id, dependent: :destroy
  validates :apply_kind, inclusion: { in: [1, 2], message: "must be either 1 (General) or 2 (Broadcast)" }
  validates :append_file_status, inclusion: { in: [0, 1, 2], message: "must be 0 (添付無し), 1 (作業中), or 9 (完了)" }
  validates :boss_check_1, inclusion: { in: [0, 1, 9], message: "must be 0 (Unconfirmed), 1 (Confirmed), or 9 (No Checker)" }
  validates :boss_check_2, inclusion: { in: [0, 1, 9], message: "must be 0 (Unconfirmed), 1 (Confirmed), or 9 (No Checker)" }
  validates :boss_check_3, inclusion: { in: [0, 1, 9], message: "must be 0 (Unconfirmed), 1 (Confirmed), or 9 (No Checker)" }
  validates :boss_check_4, inclusion: { in: [0, 1, 9], message: "must be 0 (Unconfirmed), 1 (Confirmed), or 9 (No Checker)" }
  validate :validate_division

  def validate_division
    unless division.is_a?(Array)
      errors.add(:division, "must be an array")
      return
    end
    invalid_elements = division - ["new", "replace", "repair"]
    unless invalid_elements.empty?
      errors.add(:division, "contains invalid elements: #{invalid_elements.join(', ')}")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    # List all attributes you want to be searchable.  Exclude sensitive attributes!
    [ "year", 
    "apply_kind", 
    "item_name", 
     "apply_emp_name", 
     "apply_emp_dep", 
     "specific_contents"]
  end


end
