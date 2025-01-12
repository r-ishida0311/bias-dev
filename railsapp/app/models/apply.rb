class Apply < ApplicationRecord
  before_save :clear_old_asset_fields
  has_many_attached :files
  belongs_to :department
  # belongs_to :add_dep
  belongs_to :division, dependent: :destroy
  accepts_nested_attributes_for :division
  has_one :boss1, dependent: :destroy
  accepts_nested_attributes_for :boss1
  before_validation :clear_reference_no_if_apply_kind_not_2
  validates :apply_kind, inclusion: { in: [1, 2], message: "は(一般設備)または(放送設備)を指定してください。" }
  accepts_nested_attributes_for :boss1, allow_destroy: true
  accepts_nested_attributes_for :division, allow_destroy: true
    # その他の関連付けやバリデーションなど
  belongs_to :apply_status
  validates :old_asset_no, format: { with: /\A[\d_]+\z/, message: "旧品資産番号には半角数字とアンダーバー(_)のみ使用できます。" }, if: -> { old_asset_no.present? && old_asset_multi == 1 }
  
  
  # validates :desired_delivery, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_YM, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_cost, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "は0以上の整数で入力してください" }
  def self.ransackable_attributes(auth_object = nil)
    ["add_dep_id", 
    "apply_emp_name", 
    "apply_kind", 
    "department_id", 
    "equipment_name", 
    "item_name", 
    "specific_contents", 
    "year", 
    "dep_name"
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
