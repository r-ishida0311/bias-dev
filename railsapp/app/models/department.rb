class Department < ApplicationRecord
  belongs_to :year

  def self.import(file)
    # Delete existing records before importing
    Department.destroy_all

    CSV.foreach(file.path, headers: true) do |row|
      # Create a new department record for each row
      department = Department.new(row.to_hash.slice(*updatable_attributes))

      # Handle potential errors during saving
      unless department.save
        Rails.logger.error("Failed to import department: #{department.errors.full_messages.join(', ')} Row: #{row}")
      end
    end
  end

  def self.updatable_attributes
    ["year_id", "dep_name"] # Removed 'id' to prevent ID conflicts
  end
end
