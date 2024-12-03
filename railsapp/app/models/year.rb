class Year < ApplicationRecord
  has_many :departments, dependent: :destroy
  validates :year, uniqueness: true, presence: true
  validates :target_year, inclusion: { in: [0, 1] }
  validate :only_one_target_year

  private

  def only_one_target_year
    if target_year == 1 && Year.where(target_year: 1).where.not(id: id).exists?
      errors.add(:target_year, "Only one record can have target_year as 1")
    end
  end
end
