module DragonhoardsHelper

   private
      def getDreyterriumLeft
         allPouches = Pouch.all
         newDreyterrium = allPouches.select{|pouch| pouch.dreyterriumamount > 0 && pouch.firstdreyterrium}
         value = newDreyterrium.count
         return value
      end

      def getEmeraldPrice
         hoardFound = Dragonhoard.find_by_id(1)
         price = hoardFound.emeraldvalue * hoardFound.emeraldrate
         return price
      end

      def increaseAttributes(type, status)
         hoardFound = Dragonhoard.find_by_id(1)
         if(hoardFound)
            logged_in = current_user
            if(logged_in && ((logged_in.pouch.privilege == "Admin") || (logged_in.pouch.privilege == "Glitchy")))
               smallIncrement = 1
               mediumIncrement = 10
               largeIncrement = 100
               #Need to eventually plan how much points to decrement for each feature upgrade
               if(type == "inccolorschemepoints" || type == "deccolorschemepoints")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.colorschemepoints - smallIncrement
                        if(min > -1)
                           hoardFound.colorschemepoints -= smallIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.colorschemepoints += smallIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "inccolorschemecleanup" || type == "deccolorschemecleanup")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.colorschemecleanup - smallIncrement
                        if(min > -1)
                           hoardFound.colorschemecleanup -= smallIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.colorschemecleanup += smallIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "inctaxbase" || type == "dectaxbase")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.taxbase - 0.0001
                        if(min > -0.0001)
                           hoardFound.taxbase -= 0.0001
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.taxbase += 0.0001
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "inctaxinc" || type == "dectaxinc")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.taxinc - 0.0001
                        if(min > -0.0001)
                           hoardFound.taxinc -= 0.0001
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.taxinc += 0.0001
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incconversioncost" || type == "decconversioncost")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.conversioncost - smallIncrement
                        if(min > -1)
                           hoardFound.conversioncost -= smallIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.conversioncost += smallIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incpointscreated" || type == "decpointscreated")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.pointscreated - smallIncrement
                        if(min > -1)
                           hoardFound.pointscreated -= smallIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.pointscreated += smallIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incblogadbannercost" || type == "decblogadbannercost")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.blogadbannercost - largeIncrement
                        if(min > -100)
                           hoardFound.blogadbannercost -= largeIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.blogadbannercost += largeIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incbloglargeimagecost" || type == "decbloglargeimagecost")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.bloglargeimagecost - largeIncrement
                        if(min > -100)
                           hoardFound.bloglargeimagecost -= largeIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.bloglargeimagecost += largeIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incblogsmallimagecost" || type == "decblogsmallimagecost")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.blogsmallimagecost - largeIncrement
                        if(min > -100)
                           hoardFound.blogsmallimagecost -= largeIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.blogsmallimagecost += largeIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incblogmusiccost" || type == "decblogmusiccost")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.blogmusiccost - mediumIncrement
                        if(min > -10)
                           hoardFound.blogmusiccost -= mediumIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.blogmusiccost += mediumIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incblogpoints" || type == "decblogpoints")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.blogpoints - smallIncrement
                        if(min > -1)
                           hoardFound.blogpoints -= smallIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.blogpoints += smallIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incblogmascotpoints" || type == "decblogmascotpoints")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.blogmascotpoints - smallIncrement
                        if(min > -1)
                           hoardFound.blogmascotpoints -= smallIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.blogmascotpoints += smallIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incemeraldvalue" || type == "decemeraldvalue")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.emeraldvalue - largeIncrement
                        if(min > -100)
                           hoardFound.emeraldvalue -= largeIncrement
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.emeraldvalue += largeIncrement
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               elsif(type == "incemeraldrate" || type == "decemeraldrate")
                  price = hoardFound.unallocatedpoints - 400
                  if(price >= 0)
                     if(status == "Decrease")
                        min = hoardFound.emeraldrate - 0.001
                        if(min > -0.001)
                           hoardFound.emeraldrate -= 0.001
                           hoardFound.unallocatedpoints -= 400
                           @dragonhoard = hoardFound
                           @dragonhoard.save
                        end
                     else
                        hoardFound.emeraldrate += 0.001
                        hoardFound.unallocatedpoints -= 400
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     end
                     redirect_to dragonhoards_path
                  else
                     flash[:error] = "Insufficient funds"
                     redirect_to dragonhoards_path
                  end
               end
            else
               redirect_to root_path
            end
         else
            redirect_to root_path
         end
      end

      def indexCommons
         allHoards = Dragonhoard.order("created_on desc")
         @dragonhoards = Kaminari.paginate_array(allHoards).page(getHoardParams("Page")).per(10)
      end

      def getHoardParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Hoard")
            value = params.require(:dragonhoard).permit(:name, :message, :dragonimage, :remote_dragonimage_url,
            :dragonimage_cache, :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache, :denholiday)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            if(type == "index")
               removeTransactions
               if(current_user && current_user.pouch.privilege == "Admin")
                  indexCommons
               else
                  allMode = Maintenancemode.find_by_id(1)
                  if(allMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     end
                  else
                     indexCommons
                  end
               end
            elsif(type == "edit" || type == "update")
               hoardFound = Dragonhoard.find_by_id(getHoardParams("Id"))
               if(hoardFound)
                  logged_in = current_user
                  if(logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Glitchy"))
                     @dragonhoard = hoardFound
                     if(type == "update")
                        if(@dragonhoard.update_attributes(getHoardParams("Hoard")))
                           flash[:success] = "Dragon hoard #{@dragonhoard.name} was successfully updated."
                           redirect_to dragonhoards_path
                        else
                           render "edit"
                        end
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "convertpoints")
               hoardFound = Dragonhoard.find_by_id(1)
               if(hoardFound)
                  logged_in = current_user
                  if(logged_in && ((logged_in.pouch.privilege == "Admin") || (logged_in.pouch.privilege == "Glitchy")))
                     price = hoardFound.unallocatedpoints - hoardFound.conversioncost
                     if(price >= 0)
                        hoardFound.contestpoints += hoardFound.pointscreated
                        hoardFound.unallocatedpoints -= hoardFound.conversioncost
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                        redirect_to dragonhoards_path
                     else
                        flash[:error] = "Insufficient funds"
                        redirect_to dragonhoards_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "inctaxbase" || type == "inctaxinc" || type == "inccolorschemepoints" || type == "inccolorschemecleanup" || type == "incconversioncost" || type == "incpointscreated" || type == "incblogadbannercost" || type == "incbloglargeimagecost" || type == "incblogsmallimagecost" || type == "incblogmusiccost" || type == "incblogpoints" || type == "incblogmascotpoints" || type == "incemeraldvalue" || type == "incemeraldrate")
               increaseAttributes(type, "Increase")
            elsif(type == "dectaxbase" || type == "dectaxinc" || type == "deccolorschemepoints" || type == "deccolorschemecleanup" || type == "decconversioncost" || type == "decpointscreated" || type == "decblogadbannercost" || type == "decbloglargeimagecost" || type == "decblogsmallimagecost" || type == "decblogmusiccost" || type == "decblogpoints" || type == "decblogmascotpoints" || type == "decemeraldvalue" || type == "decemeraldrate")
               increaseAttributes(type, "Decrease")
            elsif(type == "buyemeralds")
               hoardFound = Dragonhoard.find_by_id(1)
               if(hoardFound)
                  logged_in = current_user
                  if(logged_in)
                     emeraldCost = hoardFound.emeraldvalue * hoardFound.emeraldrate
                     profit = emeraldCost * 0.05
                     price = logged_in.pouch.amount - emeraldCost
                     if(price >= 0)
                        logged_in.pouch.amount = price
                        logged_in.pouch.emeraldamount += 1
                        hoardFound.profit += profit
                        @pouch = logged_in.pouch
                        @pouch.save
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                        flash[:success] = "Congratulations you have purchased an emerald!"
                        redirect_to dragonhoards_path
                     else
                        flash[:error] = "Insufficient funds"
                        redirect_to dragonhoards_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "withdraw")
               hoardFound = Dragonhoard.find_by_id(1)
               if(hoardFound)
                  logged_in = current_user
                  if(logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Glitchy"))
                     #Adds the collected points to the treasury
                     points = hoardFound.profit
                     hoardFound.unallocatedpoints += points
                     hoardFound.profit -= points
                     @dragonhoard = hoardFound
                     @dragonhoard.save
                     flash[:success] = "#{points} points have been added to the treasury!"
                     redirect_to dragonhoards_path
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "addore")
               hoardFound = Dragonhoard.find_by_id(1)
               if(hoardFound)
                  logged_in = current_user
                  if(logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Glitchy"))
                     if(hoardFound.dreyterrium_start < 200 && getDreyterriumLeft == 0)
                        #Increases the dreyterrium available
                        hoardFound.dragonhoard.dreyterrium_start += 10
                        hoardFound.unallocatedpoints -= 200
                        if(hoardFound.dreyterrium_extracted != 0)
                           hoardFound.dreyterrium_extracted = 0
                        end
                        if(hoardFound.dreyterriumcurrent_value != hoardFound.dreyterriumbasepoints)
                           hoardFound.dreyterriumcurrent_value = hoardFound.dreyterriumbasepoints
                        end
                        flash[:success] = "New Dreyterrium was successfully added."
                        @dragonhoard = hoardFound
                        @dragonhoard.save
                     else
                        flash[:error] = "There is still Dreyterrium left or you hit the max."
                        redirect_to dragonhoards_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
