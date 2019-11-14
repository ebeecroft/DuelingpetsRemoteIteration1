module InventoriesHelper

   private
      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  #Remember to come back and add Kaminari to this!
                  allInventories = Inventory.order("id desc")
                  @inventories = allInventories
               else
                  redirect_to root_path
               end
            elsif(type == "show")
               inventoryFound = Inventory.find_by_id(params[:id])
               logged_in = current_user
               if(inventoryFound && logged_in)
                  if(logged_in.id == inventoryFound.user_id)
                     @user = logged_in
                     @inventory = inventoryFound
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
