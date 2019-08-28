class Dragonhoard < ApplicationRecord
   #Uploader section
   mount_uploader :dragonimage, DragonimageUploader
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex information for dragonhoard
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validation section
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :message, presence: true
end
