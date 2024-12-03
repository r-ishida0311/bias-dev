class FilesTab < ApplicationRecord
    self.table_name='FilesTab'
  self.primary_key = 'file_id'
  belongs_to :ApplyDataTab, foreign_key: :apply_data_id
end
