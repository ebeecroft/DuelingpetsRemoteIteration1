class Inventory < ApplicationRecord
   #Inventory related
   belongs_to :user, optional: true
end
