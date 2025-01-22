class Department < ApplicationRecord
  belongs_to :year
  

  def self.ransackable_attributes(auth_object = nil)
    ["dep_name"]
  end

end
