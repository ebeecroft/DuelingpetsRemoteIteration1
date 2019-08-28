module UserupgradesHelper

   private
      def getUpgradeParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Upgrade")
            value = params.require(:userupgrade).permit(:pouchbase, :pouchinc, :pouchcost, :pouchmax,
            :emeraldbase, :emeraldinc, :emeraldcost, :emeraldmax, :blogbase, :bloginc, :blogcost, :blogmax
            :dreyterriumbase, :dreyterriuminc, :dreyterriumcost, :dreyterriummax)
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
            if(current_user && current_user.pouch.privilege == "Admin")
               if(type == "index")
                  removeTransactions
                  allUpgrades = Userupgrade.order("id asc")
                  @userupgrades = Kaminari.paginate_array(allUpgrades).page(getUpgradeParams("Page")).per(10)
               elsif(type == "edit" || type == "update")
                  upgradeFound = Userupgrade.find_by_id(getUpgradeParams("Id"))
                  if(upgradeFound)
                     @userupgrade = upgradeFound
                     if(type == "update")
                        if(@userupgrade.update_attributes(getUpgradeParams("Upgrade")))
                           flash[:success] = "The userupgrade was successfully updated."
                           redirect_to userupgrades_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/crazybat"
                  end
               end
            else
               redirect_to root_path
            end
         end
      end
end
