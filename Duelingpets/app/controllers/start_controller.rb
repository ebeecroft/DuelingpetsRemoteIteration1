class StartController < ApplicationController
   include StartHelper
   #include EconomyretrievalHelper

   def home
      mode "home"
   end

   def aboutus
      mode "aboutus"
   end

   def contact
      mode "contact"
   end

   def verify
      mode "verify"
   end

   def verify2
      mode "verify2"
   end

   def muteAudio
      mode "muteAudio"
   end

   def admincontrols
      mode "admincontrols"
   end

   def keymastercontrols
      mode "keymastercontrols"
   end

   def reviewercontrols
      mode "reviewercontrols"
   end
end
