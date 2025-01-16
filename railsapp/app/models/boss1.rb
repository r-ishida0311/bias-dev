class Boss1 < ApplicationRecord
  belongs_to :apply
  validates :boss_no, presence: true

end
