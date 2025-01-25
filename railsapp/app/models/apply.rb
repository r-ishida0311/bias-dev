class Apply < ApplicationRecord
  before_save :clear_old_asset_fields
  before_validation :clear_reference_no_if_apply_kind_not_2

  validates :apply_kind, inclusion: { in: [1, 2], message: "は(一般設備)または(放送設備)を指定してください。" }
  validates :old_asset_no, format: { with: /\A[\d_]+\z/, message: "旧品資産番号には半角数字とアンダーバー(_)のみ使用できます。" }, if: -> { old_asset_no.present? && old_asset_multi == 1 }

  has_many_attached :files
  belongs_to :department
  
  has_one :division, dependent: :destroy
  accepts_nested_attributes_for :division

  has_one :boss1, dependent: :destroy
  accepts_nested_attributes_for :boss1
    
  has_one :apply_status, dependent: :destroy
  accepts_nested_attributes_for :apply_status

  has_one :sk_comment, dependent: :destroy 
  accepts_nested_attributes_for :sk_comment

  has_one :tech_comment, dependent: :destroy 
  accepts_nested_attributes_for :tech_comment

  has_one :tech_reply_comment, dependent: :destroy 
  accepts_nested_attributes_for :tech_reply_comment

  has_one :tech_status, dependent: :destroy 
  accepts_nested_attributes_for :tech_status

  has_one :approve_status, dependent: :destroy 
  accepts_nested_attributes_for :approve_status

  def self.ransackable_attributes(auth_object = nil)
    [
    "apply_emp_name", 
    "apply_kind", 
    "equipment_name", 
    "item_name", 
    "specific_contents", 
    "year", 
    ]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["department"]
  end


  private

  def clear_reference_no_if_apply_kind_not_2
    self.reference_no = nil unless apply_kind == 2
  end

  def validate_old_asset_no
    if old_asset_no.present? && old_asset_multi == 1 && !old_asset_no.match(/\A[\d_]+\z/)
      errors.add(:old_asset_no, "旧品資産番号には半角数字とアンダーバー(_)のみ使用できます。")
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
