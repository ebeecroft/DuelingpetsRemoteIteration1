class DragonhoardsController < ApplicationController
   include DragonhoardsHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def withdraw
      mode "withdraw"
   end

   def buyemeralds
      mode "buyemeralds"
   end

   def convertpoints
      mode "convertpoints"
   end

   def inctaxbase
      mode "inctaxbase"
   end

   def inctaxinc
      mode "inctaxinc"
   end

   def inccolorschemepoints
      mode "inccolorschemepoints"
   end

   def inccolorschemecleanup
      mode "inccolorschemecleanup"
   end

   def incconversioncost
      mode "incconversioncost"
   end

   def incpointscreated
      mode "incpointscreated"
   end

   def incblogadbannercost
      mode "incblogadbannercost"
   end

   def incbloglargeimagecost
      mode "incbloglargeimagecost"
   end

   def incblogsmallimagecost
      mode "incblogsmallimagecost"
   end

   def incblogmusiccost
      mode "incblogmusiccost"
   end

   def incblogpoints
      mode "incblogpoints"
   end

   def incblogmascotpoints
      mode "incblogmascotpoints"
   end

   def incemeraldvalue
      mode "incemeraldvalue"
   end

   def incemeraldrate
      mode "incemeraldrate"
   end

   def dectaxbase
      mode "dectaxbase"
   end

   def dectaxinc
      mode "dectaxinc"
   end

   def deccolorschemepoints
      mode "deccolorschemepoints"
   end

   def deccolorschemecleanup
      mode "deccolorschemecleanup"
   end

   def decconversioncost
      mode "decconversioncost"
   end

   def decpointscreated
      mode "decpointscreated"
   end

   def decblogadbannercost
      mode "decblogadbannercost"
   end

   def decbloglargeimagecost
      mode "decbloglargeimagecost"
   end

   def decblogsmallimagecost
      mode "decblogsmallimagecost"
   end

   def decblogmusiccost
      mode "decblogmusiccost"
   end

   def decblogpoints
      mode "decblogpoints"
   end

   def decblogmascotpoints
      mode "decblogmascotpoints"
   end

   def decemeraldvalue
      mode "decemeraldvalue"
   end

   def decemeraldrate
      mode "decemeraldrate"
   end

   def addore
      mode "addore"
   end
end
