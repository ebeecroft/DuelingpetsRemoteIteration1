module OcsHelper

   private
      def getOcParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "OcId")
            value = params[:blog_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Oc")
            value = params.require(:oc).permit(:name, :description, :nickname, :species, :age, :personality, :likesanddislikes, :backgroundandhistory, :relatives, :family, :friends, :world, :alignment, :alliance, :elements, :appearance, :clothing, :accessories, :image, :remote_image_url, :image_cache, :ogg, :remote_ogg_url, :ogg_cache,
            :mp3, :remote_mp3_url, :mp3_cache, :created_on, :updated_on, :reviewed_on, :reviewed, :user_id, :bookgroup_id)
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
               userOcs = userFound.ocs.order("reviewed_on desc, created_on desc")
               ocsReviewed = userBlogs.select{|oc| oc.reviewed || (current_user && oc.user_id == current_user.id)}
               @user = userFound
            else
               render "webcontrols/crazybat"
            end
         else
            allOcs = Oc.order("reviewed_on desc, created_on desc")
            ocsReviewed = allOcs.select{|oc| oc.reviewed || (current_user && oc.user_id == current_user.id)}
         end
         @ocs = Kaminari.paginate_array(ocsReviewed).page(getOcParams("Page")).per(10)
      end

      def optional
         value = getOcParams("User")
         return value
      end

      def editCommons(type)
         ocFound = Oc.find_by_id(getOcParams("Id"))
         if(ocFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == ocFound.user_id) || logged_in.pouch.privilege == "Admin"))
               ocFound.updated_on = currentTime
               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               ocFound.reviewed = false
               @oc = ocFound
               @user = User.find_by_vname(ocFound.user.vname)
               if(type == "update")
                  if(@oc.update_attributes(getOcParams("Oc")))
                     flash[:success] = "OC #{@oc.name} was successfully updated."
                     redirect_to user_oc_path(@oc.user, @oc)
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
         ocFound = Oc.find_by_id(getOcParams("Id"))
         if(ocFound)
            removeTransactions
            if(ocFound.reviewed || current_user && ((ocFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @oc = ocFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == ocFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @oc.destroy
                     flash[:success] = "#{@oc.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to ocs_list_path
                     else
                        redirect_to user_ocs_path(ocFound.user)
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
               blogMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || blogMode.maintenance_on)
                  if(current_user && current_user.admin)
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/blogs/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               blogMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || blogMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/blogs/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getOcParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newOc = logged_in.ocs.new
                        if(type == "create")
                           newOc = logged_in.ocs.new(getOcParams("Oc"))
                           newOc.created_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        @oc = newOc
                        @user = userFound

                        if(type == "create")
                           if(@oc.save)
                              hoard = Dragonhoard.find_by_id(1)
                              #pointsForOcs = hoard.colorschemepoints
                              pointsForOcs = 16
                              pouchFound = Pouch.find_by_user_id(logged_in.id)
                              pouchFound.amount += pointsForOcs

                              #Adds the oc points to the economy
                              newTransaction = Economy.new(params[:economy])
                              newTransaction.econtype = "Content"
                              newTransaction.content_type = "OC"
                              newTransaction.name = "Source"
                              newTransaction.amount = pointsForOcs
                              newTransaction.user_id = ocFound.user_id
                              newTransaction.created_on = currentTime
                              @economytransaction = newTransaction
                              @economytransaction.save

                              ContentMailer.content_created(@oc, "OC", pointsForOcs).deliver_later(wait: 5.minutes)
                              @pouch = pouchFound
                              @pouch.save
                              flash[:success] = "#{@oc.name} was successfully created."
                              redirect_to user_oc_path(@user, @oc)
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
                  blogMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || blogMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/blogs/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               blogMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || blogMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/blogs/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allOcs = Oc.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        ocsToReview = allOcs.select{|oc| !oc.reviewed}
                        @ocs = Kaminari.paginate_array(ocsToReview).page(getOcParams("Page")).per(4)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @ocs = allOcs.page(getOcParams("Page")).per(4)
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
                  ocFound = Oc.find_by_id(getOcParams("OcId"))
                  if(artFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if(logged_in.admin || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           ocFound.reviewed = true
                           pouch = Pouch.find_by_user_id(ocFound.user_id)
                           pointsForOc = 16
                           pouch.amount += pointsForOc
                           @pouch = pouch
                           @pouch.save
                           @oc = ocFound
                           @oc.save
                           #ContentMailer.art_approved(@art, pointsForArt).deliver
                           #allWatches = Watch.all
                           #watchers = allWatches.select{|watch| (((watch.watchtype.name == "Arts" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Artsounds" || watch.watchtype.name == "Artmovies")) || (watch.watchtype.name == "Maincontent" || watch.watchtype.name == "All")) && watch.from_user.id != @art.user_id}
                           #if(watchers.count > 0)
                           #   watchers.each do |watch|
                           #      UserMailer.new_art(@art, watch).deliver
                           #   end
                           #end
                           value = "#{@oc.user.vname}'s oc #{@oc.name} was approved."
                        else
                           @oc = ocFound
                           #ContentMailer.art_denied(@art).deliver
                           value = "#{@oc.user.vname}'s oc #{@oc.name} was denied."
                        end
                        flash[:success] = value
                        redirect_to ocs_review_path
                     else
                        redirect_to root_path
                     end
                  else
                     render "start/crazybat"
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
