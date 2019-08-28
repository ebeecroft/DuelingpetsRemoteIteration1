class PouchesController < ApplicationController
   include PouchesHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def upgradepouch
      mode "upgradepouch"
   end

   def upgradeemerald
      mode "upgradeemerald"
   end

   def upgradeblog
      mode "upgradeblog"
   end

   def upgradedreyterrium
      mode "dreyterrium"
   end
end
