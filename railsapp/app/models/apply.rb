class Apply < ApplicationRecord
  before_save :clear_old_asset_fields
  has_many_attached :files
  belongs_to :department
  # belongs_to :add_dep
  belongs_to :division, optional: true 
  accepts_nested_attributes_for :division
  has_one :boss1
  accepts_nested_attributes_for :boss1
  before_validation :clear_reference_no_if_apply_kind_not_2
  validates :apply_kind, inclusion: { in: [1, 2], message: "は(一般設備)または(放送設備)を指定してください。" }
  validate :validate_old_asset_no
  
  # validates :desired_delivery, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_YM, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_cost, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "は0以上の整数で入力してください" }
  def self.ransackable_attributes(auth_object = nil)
    ["add_dep_id", 
    "apply_emp_name", 
    "apply_emp_no", 
    "apply_kind", 
    "apply_status", 
    "apply_update_date", 
    "approve_status", 
    "approve_update_date", 
    "boss_update_date", 
    "category", "created_at", 
    "department_id", 
    "desired_delivery", 
    "division_id", 
    "equipment_name", 
    "estimated_cost", 
    "id", 
    "id_value", 
    "item_name", 
    "location", 
    "manufacturer_name", 
    "old_asset_YM", 
    "old_asset_cost", 
    "old_asset_handling", 
    "old_asset_multi", 
    "old_asset_no", 
    "quantity", 
    "reason", 
    "reference_no", 
    "sk_approve_cost", 
    "sk_comment", 
    "specific_contents", 
    "supplier_name", 
    "tech_check_name", 
    "tech_status", 
    "tech_update_date", 
    "updated_at", 
    "wg_comment", 
    "wg_comment_status", 
    "wg_comment_update_date", 
    "wg_reply_comment", 
    "wg_reply_comment_update_date", 
    "year"]
  end
  private

  def clear_reference_no_if_apply_kind_not_2
    self.reference_no = nil unless apply_kind == 2
  end

  def validate_old_asset_no
    if old_asset_no.present? && old_asset_multi == 1 && !old_asset_no.match(/\A[\d_]+\z/)
      errors.add(:old_asset_no, "は半角数字と_のみを許可します。")
    end
  end

  def clear_old_asset_fields
    if old_asset_multi == 0
      self.old_asset_no = nil
      self.old_asset_YM = nil
      self.old_asset_handling = nil
      self.old_asset_cost = nil
    end
  end



end
