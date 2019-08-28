class Userupgrade < ApplicationRecord
   #Regex information for userupgrade
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the userupgrade information upon submission
   validates :pouchbase, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :pouchinc, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :pouchcost, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :pouchmax, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldbase, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldinc, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldcost, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldmax, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :blogbase, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :bloginc, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :blogcost, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :blogmax, presence: true, format: { with: VALID_VALUE_REGEX}
end
