class Boss1 < ApplicationRecord
  belongs_to :apply
  validates :boss_no, presence: true
  validates :boss_name, presence: true
end
