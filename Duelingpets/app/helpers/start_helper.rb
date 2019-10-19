module StartHelper

   private
      def getTimeDifference(type, content)
         value = ""
         if(type == "User")
            value = (currentTime - content.joined_on)
         end
         return value
      end

      def getStatsTimeframe(type, timeframe)
         allContents = ""
         firstContent = ""
         nonBot = ""   

         if(type == "User")
            allContents = User.all
            firstContent = User.first.joined_on.year
            nonBot = allContents.select{|content| ((content.pouch.privilege != "Bot") && (content.pouch.privilege != "Trial")) && (content.pouch.privilege != "Admin")}
         end

         #Finds all the content created on a specific day
         day = nonBot.select{|content| getTimeDifference(type, content) <= 1.day}
         week = nonBot.select{|content| getTimeDifference(type, content) <= 1.week}
         month = nonBot.select{|content| getTimeDifference(type, content) <= 1.month}
         year = nonBot.select{|content| getTimeDifference(type, content) <= 1.year}
         threeyear = nonBot.select{|content| getTimeDifference(type, content) <= 3.years}
         bacot = nonBot.select{|content| getTimeDifference(type, content) > (firstContent - 1.year)}

         #Sums up the data for the particular timeframe
         dayCount = day.count
         weekCount = week.count - dayCount
         monthCount = month.count - weekCount - dayCount
         yearCount = year.count - monthCount - weekCount - dayCount
         dreiJahreCount = threeyear.count - yearCount - monthCount - weekCount - dayCount
         bacotCount = bacot.count - dreiJahreCount - yearCount - monthCount - weekCount - dayCount

         total = dayCount
         if(timeframe == "Week")
            total = weekCount
         elsif(timeframe == "Month")
            total = monthCount
         elsif(timeframe == "Year")
            total = yearCount
         elsif(timeframe == "Threeyears")
            total = dreiJahreCount
         elsif(timeframe == "BaconOfTomato")
            total = bacotCount
         elsif(timeframe == "All")
            total = nonBot.count
         end
         return total
      end

      def userAlertNotify
         #Displays the alerts to the user if any
         alertLimit = 6
         holdAlert = ""
         count = 0
         (0..alertLimit).each do |i|
            count = alertFound(i)
            if(count > 0)
               temp = alertString(i)
               mainString = "You have "
               if(holdAlert == "")
                  holdAlert = mainString + count.to_s + " " + temp
               else
                  holdAlert += "\n"
                  holdAlert += (mainString + count.to_s + " " + temp)
               end
            end
         end
         textString = holdAlert
         alert = textString.gsub(/\n/, '<br/>')
         return alert
      end

      def alertString(value)
         #Handles the userAlert messages
         character = ""
         if(value == 0)
            character = "colors that are currently in beta!"
         elsif(value == 1)
            character = "pms that are waiting to be read!"
         elsif(value == 2)
            character = "friendrequests that are awaiting review!"
         elsif(value == 3)
            character = "foruminvites that are awaiting review!"
         elsif(value == 4)
            character = "forum moderator requests to review!"
         elsif(value == 5)
            character = "container moderator requests to review!"
         elsif(value == 6)
            character = "maintopic moderator requests to review!"
         end
         return character
      end

      def alertFound(value)
         #Detects user content alerts
         amount = 0
         userContent = []
         if(value == 0)
            allContent = Colorscheme.order("created_on desc")
            userContent = allContent.select{|content| (content.user_id == current_user.id)}
         elsif(value == 1)
            #allContent = Pm.order("created_on desc")
            #userContent = allContent.select{|content| ((content.to_user.id == current_user.id) && content.user2_unread) || ((content.from_user.id == current_user.id) && content.user1_unread)}
         elsif(value == 2)
            #allContent = Friendrequest.order("created_on desc")
            #userContent = allContent.select{|content| (content.user_id == current_user.id)}
         elsif(value == 3)
            #allContent = Foruminvite.order("created_on desc")
            #userContent = allContent.select{|content| (content.user_id == current_user.id)}
         elsif(value == 4)
            #allContent = Forummoderatorrequest.order("created_on desc")
            #userContent = allContent.select{|content| (content.forum.user_id == current_user.id)}
         elsif(value == 5)
            #allContent = Containermoderatorrequest.order("created_on desc")
            #userContent = allContent.select{|content| (content.topiccontainer.forum.user_id == current_user.id)}
         elsif(value == 6)
            #allContent = Maintopicmoderatorrequest.order("created_on desc")
            #userContent = allContent.select{|content| (content.maintopic.topiccontainer.forum.user_id == current_user.id)}
         end

         if(value == 0)
            awaitingReview = userContent.select{|content| !content.activated}
            amount = awaitingReview.count
         elsif(value == 1)
            #amount = userContent.count
         elsif(value > 1)
            #awaitingReview = userContent.select{|content| content.status == "Inprocess"}
            #amount = awaitingReview.count
         end
         return amount 
      end

      def checkforAlerts
         #Determine if any alerts have happened
         amount = 0
         alertLimit = 6
         (0..alertLimit).each do |i|
            amount += alertFound(i)
         end
         return amount
      end

      def homepageAlerts
         value = ""
         criticalMode = Maintenancemode.find_by_id(2)
         betaMode = Maintenancemode.find_by_id(3)
         grandMode = Maintenancemode.find_by_id(4)
         if(criticalMode.maintenance_on)
            value = "[Engine Overheating!!!!!]"
         elsif(betaMode.maintenance_on)
            value = "[Beta]"
         elsif(grandMode.maintenance_on)
            value = "[Grand-Opening]"
         end
         return value
      end

      def gateStatus
         control = Webcontrol.find_by_id(1)
         if(control.gate_open)
            value = "Registration is currently open!"
         else
            value = "Registration is currently closed!"
         end
         return value
      end

      def criticalErrors
         value = 0
         criticalMode = Maintenancemode.find_by_id(2)
         if(criticalMode.maintenance_on)
            value = 1
         end
         return value
      end

      def userprofile(type)
         profile = (link_to("Login", login_path) + " " + link_to("Register", register_path))
         if(type == "User")
            profile = (link_to(current_user.vname, current_user) + " " + link_to("Logout", logout_path, method: "delete"))
         end
         return profile
      end

      def displayType(type)
         control = Webcontrol.find_by_id(1)
         value = ""

         #Displays a given image to the screen
         if(type == "Favicon")
            value = control.favicon_url(:thumb)
         elsif(type == "Mascot")
            value = control.mascot_url(:thumb)
         elsif(type == "Banner")
            value = control.banner_url(:thumb)
         else
            raise "Invalid type of display was detected!"
         end
         return value
      end

      def mode(type)
         if(timeExpired)
            logout_user
            logoutExpiredUsers
            redirect_to root_path
         else
            if(type == "home" || type == "aboutus" || type == "hubworld")
               #Initially empty
               removeTransactions
               if(type == "aboutus")
                  displayGreeter("Aboutus")
               end
            elsif(type == "contact" || type == "verify" || type == "verify2")
               #Consider adding a greater to contact page
               removeTransactions
               if(type == "verify")
                  color_value = params[:session][:color].downcase
                  if(color_value)
                     results = `public/Resources/Code/verification/verify #{color_value}`
                     validMatch = results

                     #Determines if we are looking at a bot or a human
                     if(!validMatch.empty? && results != "Invalid")
                        params[:session][:create] = color_value
                        render "contact2"
                     else
                        flash[:error] = "Person verification failed. Please try again."
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "Invalid color value"
                     redirect_to root_path
                  end
               elsif(type == "verify2")
                  name_value = params[:session][:name].downcase
                  email_value = params[:session][:email].downcase
                  subject_value = params[:session][:subject]
                  body_value = params[:session][:body]
                  @name = name_value
                  @email = email_value
                  @subject = subject_value
                  @body = body_value
                  if(name_value.empty? || email_value.empty? || subject_value.empty? || body_value.empty?)
                     flash[:error] = "One of the parameters was empty please ensure all are filled in."
                  else
                     flash[:success] = "Your contact info has now been sent."
                     UserMailer.contact(@name, @email, @subject, @body).deliver_now
                  end
                  redirect_to root_path
               end
            elsif(type == "muteAudio")
               if(current_user)
                  if(current_user.userinfo.mute_on)
                     current_user.userinfo.mute_on = false
                  else
                     current_user.userinfo.mute_on = true
                  end
                  @userinfo = current_user.userinfo
                  @userinfo.save
               end
               if(params[:pageType] == "Home")
                  redirect_to root_path
               elsif(params[:pageType] == "Hoard")
                  redirect_to dragonhoards_path
               elsif(params[:pageType] == "User")
                  redirect_to user_path(current_user)
               elsif(params[:pageType] == "Missing")
                  redirect_to crazybat_path
               elsif(params[:pageType] == "CreativeOC")
                  redirect_to new_user_oc_path(current_user)
               elsif(params[:pageType] == "Usermain")
                  redirect_to root_path
               end
            elsif(type == "admincontrols" || type == "keymastercontrols" || type == "reviewercontrols" || type == "managercontrols")
            end
         end
      end
end
