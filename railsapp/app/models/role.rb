class Role < ApplicationRecord
 belongs_to :department

 def self.ransackable_attributes(auth_object = nil)
  ["role"]
end

end
