class Item < ApplicationRecord
   #Items related
   belongs_to :user, optional: true
   belongs_to :itemtype, optional: true

   #Uploader section
   mount_uploader :itemart, ItemartUploader

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the blog information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
   validates :hp, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :atk, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :def, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :spd, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :fun, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :hunger, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :knowledge, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :durability, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :rarity, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :cost, presence: true, format: { with: VALID_VALUE_REGEX}
end
