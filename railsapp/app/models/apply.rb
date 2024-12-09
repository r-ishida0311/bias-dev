class Apply < ApplicationRecord
  belongs_to :department
  # belongs_to :add_dep
  belongs_to :division, optional: true 
  accepts_nested_attributes_for :division
  has_one :boss1
  accepts_nested_attributes_for :boss1

  validates :apply_kind, inclusion: { in: [1, 2], message: "は1(一般設備)または2(放送設備)を指定してください。" }
  validates :tech_status, inclusion: { in: [0, 1], message: "は0(未確認)または1(確認済)を指定してください。" }
  validates :approve_status, inclusion: { in: [0, 1, 2, 9], message: "は0(未承認), 1(A案件), 2(B案件), または9(否認)を指定してください。" }
  validates :old_asset_multi, inclusion: { in: [0, 1], message: "は0(なし)または1(あり)を指定してください。" }
  # validates :desired_delivery, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_YM, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_cost, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "は0以上の整数で入力してください" }
  def self.ransackable_attributes(auth_object = nil)
    ["add_dep_id", "apply_emp_name", "apply_emp_no", "apply_kind", "apply_status", "apply_update_date", "approve_status", "approve_update_date", "boss_update_date", "category", "created_at", "department_id", "desired_delivery", "division_id", "equipment_name", "estimated_cost", "id", "id_value", "item_name", "location", "manufacturer_name", "old_asset_YM", "old_asset_cost", "old_asset_handling", "old_asset_multi", "old_asset_no", "quantity", "reason", "reference_no", "sk_approve_cost", "sk_comment", "specific_contents", "supplier_name", "tech_check_name", "tech_status", "tech_update_date", "updated_at", "wg_comment", "wg_comment_status", "wg_comment_update_date", "wg_reply_comment", "wg_reply_comment_update_date"]
  end

end
