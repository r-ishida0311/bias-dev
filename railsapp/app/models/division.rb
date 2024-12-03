class Division < ApplicationRecord
  validates :new_pur, inclusion: { in: [0, 1], message: "は0または1を指定してください。" }
  validates :replace, inclusion: { in: [0, 1], message: "は0または1を指定してください。" }
  validates :repair, inclusion: { in: [0, 1], message: "は0または1を指定してください。" }
  before_save :set_oh_value

  private

  def set_oh_value
    if new_pur == 0 && replace == 0 && repair == 1
      self.oh = 1
    else
      self.oh = 0
    end
  end

end
