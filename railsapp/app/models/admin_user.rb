class AdminUser < ApplicationRecord
  validates :emp_no, numericality: { only_integer: true, greater_than_or_equal_to: 1000, less_than_or_equal_to: 9999, message: "は4桁の整数でなければなりません。" }, uniqueness: { message: "は既に使用されています。" }

  validates :tech_flag, inclusion: { in: [0, 1], message: "は0または1でなければなりません。" }
  validates :wg_flag, inclusion: { in: [0, 1], message: "は0または1でなければなりません。" }
  validates :sys_flag, inclusion: { in: [0, 1], message: "は0または1でなければなりません。" }
  validates :emp_name, presence: {message: "を入力してください。"}
end

