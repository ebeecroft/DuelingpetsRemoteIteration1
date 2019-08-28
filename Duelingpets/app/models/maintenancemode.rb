class Maintenancemode < ApplicationRecord
   #Validates the maintenancemode parameters
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9-]+\z/i
   validates :name, presence: true, format: { with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
end
