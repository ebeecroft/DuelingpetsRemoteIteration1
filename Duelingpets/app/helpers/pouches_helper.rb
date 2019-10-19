module PouchesHelper

   private
      def getUpgradeCost(type, pouch)
         upgrade = Userupgrade.find_by_id(1)
         cost = 0
         if(type == "Pouch")
            if(pouch.pouchlevel < upgrade.pouchmax)
               cost = upgrade.pouchcost * (pouch.pouchlevel + 1)
            end
         elsif(type == "OC")
            if(pouch.oclevel < upgrade.ocmax)
               cost = upgrade.occost * (pouch.oclevel + 1)
            end
         elsif(type == "Blog")
            if(pouch.bloglevel < upgrade.blogmax)
               cost = upgrade.blogcost * (pouch.bloglevel + 1)
            end
         elsif(type == "Emerald")
            if(pouch.emeraldlevel < upgrade.emeraldmax)
               cost = upgrade.emeraldcost * (pouch.emeraldlevel + 1)
            end
         elsif(type == "Dreyterrium")
            if(pouch.dreyterriumlevel < upgrade.dreyterriummax)
               cost = upgrade.dreyterriumcost * (pouch.dreyterriumlevel + 1)
            end
         end
         return cost
      end

      def getUpgradeLimit(pouch, type)
         upgrade = Userupgrade.find_by_id(1)
         max = 0
         if(type == "Pouch")
            max = upgrade.pouchbase + (upgrade.pouchinc * pouch.pouchlevel)
         elsif(type == "OC")
            max = upgrade.ocbase + (upgrade.ocinc * pouch.oclevel)
         elsif(type == "Blog")
            max = upgrade.blogbase + (upgrade.bloginc * pouch.bloglevel)
         elsif(type == "Emerald")
            max = upgrade.emeraldbase + (upgrade.emeraldinc * pouch.emeraldlevel)
         elsif(type == "Dreyterrium")
            max = upgrade.dreyterriumbase + (upgrade.dreyterriuminc * pouch.dreyterriumlevel)
         end
         return max
      end

      def getUpgradeMax(type)
         upgrade = Userupgrade.find_by_id(1)
         max = 0
         if(type == "Pouch")
            max = upgrade.pouchmax
         elsif(type == "OC")
            max = upgrade.ocmax
         elsif(type == "Blog")
            max = upgrade.blogmax
         elsif(type == "Emerald")
            max = upgrade.emeraldmax
         elsif(type == "Dreyterrium")
            max = upgrade.dreyterriummax
         end
         return max
      end

      def pouch_params
         params.require(:pouch).permit(:privilege)
      end

      def upgradeUser(type, logged_in)
         pouchFound = Pouch.find_by_id(params[:pouch_id])
         if(pouchFound)
            if(logged_in.id == pouchFound.user.id)
               price = 0
               if(type == "upgradepouch")
                  price = getUpgradeCost("Pouch", pouchFound)
               elsif(type == "upgradeoc")
                  price = getUpgradeCost("OC", pouchFound)
               elsif(type == "upgradeblog")
                  price = getUpgradeCost("Blog", pouchFound)
               elsif(type == "upgradeemerald")
                  price = getUpgradeCost("Emerald", pouchFound)
               elsif(type == "upgradedreyterrium")
                  price = getUpgradeCost("Dreyterrium", pouchFound)
               end
               if(price != 0 && pouchFound.amount >= price)
                  pouchFound.amount -= price
                  if(type == "upgradepouch")
                     pouchFound.pouchlevel += 1
                  elsif(type == "upgradeoc")
                     pouchFound.oclevel += 1
                  elsif(type == "upgradeblog")
                     pouchFound.bloglevel += 1
                  elsif(type == "upgradeemerald")
                     pouchFound.emeraldlevel += 1
                  elsif(type == "upgradedreyterrium")
                     pouchFound.dreyterriumlevel += 1
                  end
                  @pouch = pouchFound
                  @pouch.save
                  if(type == "upgradepouch")
                     message = "Your pouch level is now: #{@pouch.pouchlevel}"
                  elsif(type == "upgradeoc")
                     message = "Your oc level is now: #{@pouch.oclevel}"
                  elsif(type == "upgradeblog")
                     message = "Your blog level is now: #{@pouch.bloglevel}"
                  elsif(type == "upgradeemerald")
                     message = "Your emerald level is now: #{@pouch.emeraldlevel}"
                  elsif(type == "upgradedreyterrium")
                     message = "Your dreyterrium level is now: #{@pouch.dreyterriumlevel}"
                  end
                  flash[:success] = message
                  redirect_to user_path(@pouch.user.vname)
               else
                  if(price == 0)
                     message = "You have already upgraded this feature to the max."
                  else
                     message = "Insufficient points to pay for this upgrade!"
                  end
                  flash[:error] = message
                  redirect_to root_path
               end
            else
               redirect_to root_path
            end
         else
            redirect_to root_path
         end
      end

      def mode(type)
         logoutExpiredUsers
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allPouches = Pouch.order("signed_in_at desc").page(params[:page]).per(10)
                  @pouches = allPouches
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               pouchFound = Pouch.find_by_id(params[:id])
               if(pouchFound)
                  logged_in = current_user
                  if(logged_in && ((pouchFound.user_id == logged_in.id) || logged_in.pouch.privilege == "Admin"))
                     @pouch = pouchFound
                     if(type == "update")
                        if(@pouch.update(pouch_params))
                           flash[:success] = "#{@pouch.user.vname} privilege was successfully updated."
                           redirect_to pouches_path
                        else
                           render "edit"
                        end
                     end
                  else
                     redirect_to root_path
                  end
               else
                  render "webcontrols/crazybat"
               end
            elsif(type == "upgradepouch" || type == "upgradeoc" || type == "upgradeblog" || type == "upgradeemerald" || type == "upgradedreyterrium")
               logged_in = current_user
               if(logged_in)
                  upgradeUser(type, logged_in)
               else
                  redirect_to root_path
               end
            else
               redirect_to root_path
            end
         end
      end
end
