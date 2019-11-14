module ItemsHelper

   private
      def getItemParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ItemId")
            value = params[:item_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Item")
            value = params.require(:item).permit(:name, :description, :hp, :atk, :def, :spd, :fun, :hunger,
            :knowledge, :durability, :rarity, :starter, :equipable, :cost, :itemtype_id, :itemart,
            :remote_itemart_url, :itemart_cache)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userItems = userFound.items.order("reviewed_on desc, created_on desc")
               itemsReviewed = userItems.select{|item| (current_user && item.user_id == current_user.id) || item.reviewed}
               @user = userFound
            else
               render "webcontrols/crazybat"
            end
         else
            allItems = Item.order("reviewed_on desc, created_on desc")
            itemsReviewed = allItems.select{|item| (current_user && item.user_id == current_user.id) || item.reviewed}
         end
         @ocs = Kaminari.paginate_array(itemsReviewed).page(getItemParams("Page")).per(10)
      end

      def optional
         value = getItemParams("User")
         return value
      end

      def editCommons(type)
         itemFound = Item.find_by_id(getItemParams("Id"))
         if(itemFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == itemFound.user_id) || logged_in.pouch.privilege == "Admin"))
               itemFound.updated_on = currentTime
               #Determines the type of itemtype the item belongs to
               allItemtypes = Itemtype.order("created_on desc")
               @itemtypes = allItemtypes
               itemFound.reviewed = false
               @item = itemFound
               @user = User.find_by_vname(itemFound.user.vname)
               if(type == "update")
                  if(@item.update_attributes(getItemParams("Item")))
                     flash[:success] = "Item #{@item.name} was successfully updated."
                     redirect_to user_item_path(@item.user, @item)
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
      end

      def showCommons(type)
         itemFound = Item.find_by_id(getItemParams("Id"))
         if(itemFound)
            removeTransactions
            if(itemFound.reviewed || current_user && ((itemFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @item = itemFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == itemFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @item.destroy
                     flash[:success] = "#{@item.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to items_list_path
                     else
                        redirect_to user_items_path(itemFound.user)
                     end
                  else
                     redirect_to root_path
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/crazybat"
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            if(type == "index") #Guests
               removeTransactions
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(current_user && current_user.admin)
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/items/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getItemParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newOc = logged_in.items.new
                        if(type == "create")
                           newItem = logged_in.items.new(getItemParams("Item"))
                           newItem.created_on = currentTime
                           newItem.updated_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allItemtypes = Itemtype.order("created_on desc")
                        @itemtypes = allItemtypes

                        @item = newItem
                        @user = userFound

                        if(type == "create")
                           if(@item.save)
                              url = "http://www.duelingpets.net/items/review" #"http://localhost:3000/blogs/review"
                              #if(type == "Production")
                              #   url = "http://www.duelingpets.net/blogs/review"
                              #end
                              ContentMailer.content_review(@item, "Item", url).deliver_now
                              flash[:success] = "#{@item.name} was successfully created."
                              redirect_to user_item_path(@user, @item)
                           else
                              render "new"
                           end
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  itemMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || itemMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allItems = Item.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        itemsToReview = allItems.select{|item| !item.reviewed}
                        @items = Kaminari.paginate_array(itemsToReview).page(getItemParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @items = allItems.page(getItemParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  itemFound = Item.find_by_id(getItemParams("ItemId"))
                  if(itemFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           itemFound.reviewed = true
                           itemFound.reviewed_on = currentTime
                           hoard = Dragonhoard.find_by_id(1)
                           pointsForItems = hoard.itempoints
                           @item = itemFound
                           @item.save
                           pouch = Pouch.find_by_user_id(@item.user_id)
                           pouch.amount += pointsForItem
                           @pouch = pouch
                           @pouch.save

                           #Adds the oc points to the economy
                           newTransaction = Economy.new(params[:economy])
                           newTransaction.econtype = "Content"
                           newTransaction.content_type = "Item"
                           newTransaction.name = "Source"
                           newTransaction.amount = pointsForItem
                           newTransaction.user_id = itemFound.user_id
                           newTransaction.created_on = currentTime
                           @economytransaction = newTransaction
                           @economytransaction.save

                           ContentMailer.content_approved(@item, "Item", pointsForItem).deliver_now
                           #allWatches = Watch.all
                           #watchers = allWatches.select{|watch| (((watch.watchtype.name == "Arts" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Artsounds" || watch.watchtype.name == "Artmovies")) || (watch.watchtype.name == "Maincontent" || watch.watchtype.name == "All")) && watch.from_user.id != @art.user_id}
                           #if(watchers.count > 0)
                           #   watchers.each do |watch|
                           #      UserMailer.new_art(@art, watch).deliver
                           #   end
                           #end
                           value = "#{@item.user.vname}'s item #{@item.name} was approved."
                        else
                           @item = itemFound
                           ContentMailer.content_denied(@item, "Item").deliver_now
                           value = "#{@item.user.vname}'s item #{@item.name} was denied."
                        end
                        flash[:success] = value
                        redirect_to items_review_path
                     else
                        redirect_to root_path
                     end
                  else
                     render "webcontrols/crazybat"
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
