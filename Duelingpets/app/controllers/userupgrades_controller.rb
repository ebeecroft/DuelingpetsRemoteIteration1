class UserupgradesController < ApplicationController
   include UserupgradesHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end
end
