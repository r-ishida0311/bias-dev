class Department < ApplicationRecord
  belongs_to :year
  
  has_many :roles, dependent: :destroy 
  accepts_nested_attributes_for :roles

  def self.ransackable_attributes(auth_object = nil)
    ["dep_name", "roles"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["roles"] #  Add this line
  end

end
