class Oc < ApplicationRecord
   #Ocs related
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :image, ImageUploader
   mount_uploader :characterogg, CharacteroggUploader
   mount_uploader :charactermp3, Charactermp3Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the blog information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
