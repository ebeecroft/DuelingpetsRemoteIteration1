class Itemtype < ApplicationRecord
   #Itemtype
   has_many :items, :foreign_key => "itemtype_id", :dependent => :destroy

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the itemtype information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :basecost, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :dreyterriumcost, presence: true, format: { with: VALID_VALUE_REGEX}
end
