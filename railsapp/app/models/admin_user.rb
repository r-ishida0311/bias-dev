class AdminUser < ApplicationRecord
  validates :emp_no, numericality: { only_integer: true, greater_than_or_equal_to: 1000, less_than_or_equal_to: 9999, message: "must be a 4-digit integer" }

  validates :tech_flag, inclusion: { in: [0, 1], message: "must be 0 or 1" }
  validates :wg_flag, inclusion: { in: [0, 1], message: "must be 0 or 1" }
  validates :sys_flag, inclusion: { in: [0, 1], message: "must be 0 or 1" } #Assumed sys is a typo for sys_flag
end
