class Apply < ApplicationRecord
  belongs_to :department
  # belongs_to :add_dep
  belongs_to :division, optional: true 
  accepts_nested_attributes_for :division
  
  validates :apply_kind, inclusion: { in: [1, 2], message: "は1(一般設備)または2(放送設備)を指定してください。" }
  validates :tech_status, inclusion: { in: [0, 1], message: "は0(未確認)または1(確認済)を指定してください。" }
  validates :approve_status, inclusion: { in: [0, 1, 2, 9], message: "は0(未承認), 1(A案件), 2(B案件), または9(否認)を指定してください。" }
  validates :old_asset_multi, inclusion: { in: [0, 1], message: "は0(なし)または1(あり)を指定してください。" }
  # validates :desired_delivery, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_YM, format: { with: /\A\d{4}-\d{2}\z/, message: "はyyyy-mmの形式で入力してください。" }
  # validates :old_asset_cost, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "は0以上の整数で入力してください" }


end
