module UsersHelper
   private
      def getBanned(user)
         allBanned = Suspendedtimelimit.order("created_on desc")
         user = allBanned.select{|banned| banned.user_id == user.id}
         return user
      end

      def getUserContent(user, type)
         value = 0
         if(type == "Blog" || type == "Adblog")
            allUserBlogs = user.blogs.all

            #Retrieves all the normal blogs that have been reviewed
            normalBlogs = allUserBlogs.select{|blog| blog.adbanner.to_s == "" && blog.largeimage1.to_s == "" && blog.largeimage2.to_s == "" && blog.largeimage3.to_s == "" && blog.smallimage1.to_s == "" && blog.smallimage2.to_s == "" && blog.smallimage3.to_s == "" && blog.smallimage4.to_s == "" && blog.smallimage5.to_s == ""}
            if(type == "Adblog")
               #Retrieves all the ad blogs that have been reviewed
               normalBlogs = allUserBlogs.select{|blog| blog.adbanner.to_s != "" || blog.largeimage1.to_s != "" || blog.largeimage2.to_s != "" || blog.largeimage3.to_s != "" || blog.smallimage1.to_s != "" || blog.smallimage2.to_s != "" || blog.smallimage3.to_s != "" || blog.smallimage4.to_s != "" || blog.smallimage5.to_s != ""}
            end
            reviewedBlogs = normalBlogs.select{|blog| blog.reviewed}

            #Displays all the blogs to the blog owner
            if(current_user && current_user.id == user.id)
               reviewedBlogs = normalBlogs
            end
            value = reviewedBlogs.count
         elsif(type == "Activatedcolors" || "Inactivecolors")
            allUserColors = user.colorschemes.all
            activatedColors = allUserColors.select{|colorscheme| colorscheme.activated}
            if(type == "Inactivecolors")
               activatedColors = allUserColors.select{|colorscheme| !colorscheme.activated}
            end
            value = activatedColors.count
         end
         return value
      end

      def user_params
         params.require(:user).permit(:firstname, :lastname, :email, :country, 
         :country_timezone, :military_time, :birthday, :login_id, :vname,
         :password, :password_confirmation, :accounttype_id, :shared)
      end

      def musicCommons(type)
         userFound = User.find_by_id(params[:id])
         if(userFound)
            if(current_user && current_user.id == userFound.id)
               userInfo = Userinfo.find_by_user_id(userFound.id)
               if(userInfo.music_on)
                  userInfo.music_on = false
               else
                  userInfo.music_on = true
               end
               @userinfo = userInfo
               @userinfo.save
               redirect_to user_path(@userinfo.user)
            end
         else
            render "webcontrols/crazybat"
         end
      end

      def showCommons(type)
         userFound = User.find_by_vname(params[:id])
         if(userFound)
            setLastpageVisited
            #visitTimer(type, userFound)
            #cleanupOldVisits
            @user = userFound
            if(type == "destroy")
               logged_in = current_user
               if(logged_in && ((logged_in.id == userFound.id) || logged_in.pouch.privilege == "Admin"))
                  adminXorCurrentUser = (logged_in.pouch.privilege == "Admin" && logged_in.id != userFound.id) || (!logged_in.pouch.privilege == "Admin" && logged_in.id == userFound.id)
                  if(adminXorCurrentUser)
                     allColors = Colorscheme.all
                     allInfos = Userinfo.all
                     userColors = allColors.select{|colorscheme| colorscheme.user_id == @user.id}
                     if(userColors.size != 0)
                        userColors.each do |colorscheme|
                           infosToChange = allInfos.select{|userinfo| userinfo.colorscheme_id == colorscheme.id}
                           if(infosToChange.size != 0)
                              infosToChange.each do |userinfo|
                                 userinfo.colorscheme_id = 1
                                 @userinfo = userinfo
                                 @userinfo.save
                              end
                           end
                        end
                     end
                     @user.destroy
                     flash[:success] = "#{@user.vname} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to users_path
                     else
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "You cannot delete the main admin account."
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         else
            render "webcontrols/crazybat"
         end
      end

      def editCommons(type)
         userFound = User.find_by_vname(params[:id])
         if(userFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == userFound.id) || logged_in.pouch.privilege == "Admin"))
               @user = userFound
               if(type == "update")
                  if(@user.update(user_params))
                     flash[:success] = "#{@user.vname} was successfully updated."
                     redirect_to user_path(@user)
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
                  allUsers = User.order("joined_on desc").page(params[:page]).per(10)
                  @users = allUsers
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(5)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        #the render section
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               removeTransactions
               if(current_user && current_user.pouch.privilege == "Admin")
                  showCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(5)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        #the render section
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     showCommons(type)
                  end
               end
            elsif(type == "music")
               if(current_user && current_user.pouch.privilege == "Admin")
                  musicCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(5)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        #the render section
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     musicCommons(type)
                  end
               end
            elsif(type == "extractore")
               userFound = User.find_by_id(params[:id])
               if(current_user && userFound && userFound.id == current_user.id)
                  if(userFound.pouch.dreyterriumamount > 0)
                     hoard = Dragonhoard.find_by_id(1)
                     hoard.dreyterrium_extracted += 1
                     if(hoard.dreyterrium_extracted < hoard.dreyterriumchange)
                        #Gives the player points based on the current value
                        points = hoard.dreyterriumcurrent_value
                        userFound.pouch.amount += points
                        userFound.pouch.dreyterriumamount -= 1
                        @pouch = userFound.pouch
                        @pouch.save
                     else
                        #Flucates the price of dreyterrium
                        hoard.dreyterriumcurrent_value += 1
                        hoard.dreyterrium_extracted = 0
                        points = hoard.dreyterriumcurrent_value
                        userFound.pouch.amount += points
                        userFound.pouch.dreyterriumamount -= 1
                        @pouch = userFound.pouch
                        @pouch.save
                     end
                     @dragonhoard = hoard
                     @dragonhoard.save
                     redirect_to user_path(userFound)
                  else
                     flash[:error] = "You don't have any dreyterrium to extract!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
