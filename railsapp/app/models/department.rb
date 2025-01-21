class Department < ApplicationRecord
  belongs_to :year
  
  has_one :role, dependent: :destroy
  accepts_nested_attributes_for :role
  
  def self.ransackable_attributes(auth_object = nil)
    ["dep_name"]
  end

end
