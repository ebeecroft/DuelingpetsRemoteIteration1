class Pouch < ApplicationRecord
   belongs_to :user, optional: true
end
