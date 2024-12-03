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
    ["apply_data_id", "year", "reference_no", "apply_kind", "item_name", "apply_emp_no", "proxy_emp_no",
     "apply_emp_name", "proxy_emp_name", "proxy_op", "apply_emp_dep", "apply_status", "tech_status",
     "tech_check_name", "approve_status", "input_step", "append_file_status", "boss_check_1", "boss_check_1_name",
     "boss_check_2", "boss_check_2_name", "boss_check_3", "boss_check_3_name", "boss_check_4", "boss_check_4_name",
     "equipment_name", "manufacturer_name", "supplier_name", "quantity", "estimated_cost", "location",
     "desired_delivery", "category", "division", "reason", "specific_contents", "old_asset_no", "old_asset_multi",
     "old_asset_YM", "old_asset_cost", "old_asset_handling", "wg_comment", "wg_comment_status", "wg_reply_comment",
     "sk_approve_cost", "sk_comment", "create_date", "update_date", "apply_update_date", "tech_update_date",
     "boss_update_date", "approve_update_date", "wg_comment_update_date", "wg_reply_comment_update_date"]
  end


end
