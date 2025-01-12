class AdminUser < ApplicationRecord
  validates :emp_no, format: { with: /\A\d{4}\z/, message: "は4桁の数字でなければなりません。" }, uniqueness: { message: "は既に使用されています。" }
  validates :tech_flag, inclusion: { in: [0, 1], message: "は0または1でなければなりません。" }
  validates :wg_flag, inclusion: { in: [0, 1], message: "は0または1でなければなりません。" }
  validates :sys_flag, inclusion: { in: [0, 1], message: "は0または1でなければなりません。" }
  validates :emp_name, presence: {message: "を入力してください。"}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "emp_name", "emp_no", "id", "id_value", "sys_flag", "tech_flag", "updated_at", "wg_flag"]
    end

end

