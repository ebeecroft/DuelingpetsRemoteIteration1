module StartHelper

   private
      def getReviewContent(type)
         value = 0
         if(type == "Creature")
            allCreatures = Creature.all
            toReview = allCreatures.select{|content| !content.reviewed}
            value = toReview.count
         elsif(type == "Item")
            allItems = Item.all
            toReview = allItems.select{|content| !content.reviewed}
            value = toReview.count
         elsif(type == "OC")
            allOCs = Oc.all
            toReview = allOCs.select{|content| !content.reviewed}
            value = toReview.count
         elsif(type == "Blog")
            allBlogs = Blog.all
            toReview = allBlogs.select{|content| !content.reviewed}
            value = toReview.count
         elsif(type == "Art")
            #toReview = allCreatures.select{|content| !content.reviewed}
         elsif(type == "Sound")
            allSounds = Sound.all
            toReview = allSounds.select{|content| !content.reviewed}
            value = toReview.count
         elsif(type == "Movie")
            #toReview = allCreatures.select{|content| !content.reviewed}
         elsif(type == "Shout")
            allShouts = Shout.all
            toReview = allShouts.select{|content| !content.reviewed}
            value = toReview.count
         end
         return value
      end

      def getTimeDifference(type, content)
         value = ""
         if(type == "User")
            value = (currentTime - content.joined_on)
         elsif(type == "Register")
            value = (currentTime - content.registered_on)
         elsif(type != "User")
            value = (currentTime - content.created_on)
         end
         return value
      end

      def getStatsTimeframe(type, timeframe)
         allContents = ""
         firstContent = ""

         if(type == "User")
            allContents = User.all
            if(allContents.count != 0)
               firstContent = User.first.joined_on.year
            end
         elsif(type == "OC")
            allContents = Oc.all
            if(allContents.count != 0)
               firstContent = Oc.first.created_on.year
            end
         elsif(type == "Item")
            allContents = Item.all
            if(allContents.count != 0)
               firstContent = Item.first.created_on.year
            end
         elsif(type == "Creature")
            allContents = Creature.all
            if(allContents.count != 0)
               firstContent = Creature.first.created_on.year
            end
         elsif(type == "PM")
            allContents = Pm.all
            if(allContents.count != 0)
               firstContent = Pm.first.created_on.year
            end
         elsif(type == "PMreply")
            allContents = Pmreply.all
            if(allContents.count != 0)
               firstContent = Pmreply.first.created_on.year
            end
         elsif(type == "Register")
            allContents = Registration.all
            if(allContents.count != 0)
               firstContent = Registration.first.registered_on.year
            end
         elsif(type == "Referral")
            #allContents = Referral.all
            #if(allContents.count != 0)
               #firstContent = Referral.first.created_on.year
            #end
         elsif(type == "Friend")
            #allContents = Friend.all
            #if(allContents.count != 0)
               #firstContent = Friend.first.created_on.year
            #end
         elsif(type == "Colorscheme")
            allContents = Colorscheme.all
            if(allContents.count != 0)
               firstContent = Colorscheme.first.created_on.year
            end
         elsif(type == "Gallery")
            #allContents = Gallery.all
            #if(allContents.count != 0)
               #firstContent = Gallery.first.created_on.year
            #end
         elsif(type == "Mainfolder")
            #allContents = Mainfolder.all
            #if(allContents.count != 0)
               #firstContent = Mainfolder.first.created_on.year
            #end
         elsif(type == "Subfolder")
            #allContents = Subfolder.all
            #if(allContents.count != 0)
               #firstContent = Subfolder.first.created_on.year
            #end
         elsif(type == "Art")
            #allContents = Art.all
            #if(allContents.count != 0)
               #firstContent = Art.first.created_on.year
            #end
         elsif(type == "Radio")
            #allContents = Radiostation.all
            #if(allContents.count != 0)
               #firstContent = Radiostation.first.created_on.year
            #end
         elsif(type == "Mainsheet")
            #allContents = Mainsheet.all
            #if(allContents.count != 0)
               #firstContent = Mainsheet.first.created_on.year
            #end
         elsif(type == "Subsheet")
            #allContents = Subfolder.all
            #if(allContents.count != 0)
               #firstContent = Subfolder.first.created_on.year
            #end
         elsif(type == "Sound")
            #allContents = Sound.all
            #if(allContents.count != 0)
               #firstContent = Sound.first.created_on.year
            #end
         elsif(type == "Channel")
            #allContents = Channel.all
            #if(allContents.count != 0)
               #firstContent = Channel.first.created_on.year
            #end
         elsif(type == "Mainplaylist")
            #allContents = Mainplaylist.all
            #if(allContents.count != 0)
               #firstContent = Mainplaylist.first.created_on.year
            #end
         elsif(type == "Subplaylist")
            #allContents = Subplaylist.all
            #if(allContents.count != 0)
               #firstContent = Subplaylist.first.created_on.year
            #end
         elsif(type == "Movie")
            #allContents = Movie.all
            #if(allContents.count != 0)
               #firstContent = Movie.first.created_on.year
            #end
         elsif(type == "Blog")
            allContents = Blog.all
            if(allContents.count != 0)
               firstContent = Blog.first.created_on.year
            end
         elsif(type == "Forum")
            #allContents = Forum.all
            #if(allContents.count != 0)
               #firstContent = Forum.first.created_on.year
            #end
         elsif(type == "Container")
            #allContents = Topiccontainer.all
            #if(allContents.count != 0)
               #firstContent = Topiccontainer.first.created_on.year
            #end
         elsif(type == "Maintopic")
            #allContents = Maintopic.all
            #if(allContents.count != 0)
               #firstContent = Maintopic.first.created_on.year
            #end
         elsif(type == "Subtopic")
            #allContents = Subtopic.all
            #if(allContents.count != 0)
               #firstContent = Subtopic.first.created_on.year
            #end
         elsif(type == "Narrative")
            #allContents = Narrative.all
            #if(allContents.count != 0)
               #firstContent = Narrative.first.created_on.year
            #end
         elsif(type == "Reply")
            #allContents = Reply.all
            #if(allContents.count != 0)
               #firstContent = Reply.first.created_on.year
            #end
         elsif(type == "Soundcritique")
            #allContents = Soundcomment.all
            #if(allContents.count != 0)
               #firstContent = Soundcomment.first.created_on.year
            #end
         elsif(type == "Soundcomment")
            #allContents = Soundcomment.all
            #if(allContents.count != 0)
               #firstContent = Soundcomment.first.created_on.year
            #end
         elsif(type == "Artcritique")
            #allContents = Artcomment.all
            #if(allContents.count != 0)
               #firstContent = Artcomment.first.created_on.year
            #end
         elsif(type == "Artcomment")
            #allContents = Artcomment.all
            #if(allContents.count != 0)
               #firstContent = Artcomment.first.created_on.year
            #end
         elsif(type == "Moviecritique")
            #allContents = Moviecomment.all
            #if(allContents.count != 0)
               #firstContent = Moviecomment.first.created_on.year
            #end
         elsif(type == "Moviecomment")
            #allContents = Moviecomment.all
            #if(allContents.count != 0)
               #firstContent = Moviecomment.first.created_on.year
            #end
         elsif(type == "Shout")
            allContents = Shout.all
            if(allContents.count != 0)
               firstContent = Shout.first.created_on.year
            end
         elsif(type == "Favoritesound")
            #allContents = Favoritesound.all
            #if(allContents.count != 0)
               #firstContent = Favoritesound.first.created_on.year
            #end
         elsif(type == "Soundstar")
            #allContents = Soundstar.all
            #if(allContents.count != 0)
               #firstContent = Soundstar.first.created_on.year
            #end
         elsif(type == "Favoriteart")
            #allContents = Favoriteart.all
            #if(allContents.count != 0)
               #firstContent = Favoriteart.first.created_on.year
            #end
         elsif(type == "Artstar")
            #allContents = Artstar.all
            #if(allContents.count != 0)
               #firstContent = Artstar.first.created_on.year
            #end
         elsif(type == "Favoritemovie")
            #allContents = Favoritemovie.all
            #if(allContents.count != 0)
               #firstContent = Favoritemovie.first.created_on.year
            #end
         elsif(type == "Moviestar")
            #allContents = Moviestar.all
            #if(allContents.count != 0)
               #firstContent = Moviestar.first.created_on.year
            #end
         elsif(type == "Blogstar")
            #allContents = Blogstar.all
            #if(allContents.count != 0)
               #firstContent = Blogstar.first.created_on.year
            #end
         elsif(type == "Watcher")
            #allContents = Watch.all
            #if(allContents.count != 0)
               #firstContent = Watch.first.created_on.year
            #end
         elsif(type == "Containersub")
            #allContents = Containersub.all
            #if(allContents.count != 0)
               #firstContent = Containersub.first.created_on.year
            #end
         elsif(type == "Maintopicsub")
            #allContents = Maintopicsub.all
            #if(allContents.count != 0)
               #firstContent = Maintopicsub.first.created_on.year
            #end
         elsif(type == "Subtopicsub")
            #allContents = Subtopicsub.all
            #if(allContents.count != 0)
               #firstContent = Subtopicsub.first.created_on.year
            #end
         elsif(type == "Forummod")
            #allContents = Forummod.all
            #if(allContents.count != 0)
               #firstContent = Forummod.first.created_on.year
            #end
         elsif(type == "Containermod")
            #allContents = Containermod.all
            #if(allContents.count != 0)
               #firstContent = Containermod.first.created_on.year
            #end
         elsif(type == "Maintopicmod")
            #allContents = Maintopicmod.all
            #if(allContents.count != 0)
               #firstContent = Maintopicmod.first.created_on.year
            #end
         elsif(type == "Forummember")
            #allContents = Forummember.all
            #if(allContents.count != 0)
               #firstContent = Forummember.first.created_on.year
            #end
         end

         total = 0
         if(firstContent.to_s != "")
            #Determine if the contents is not bot related
            if(type == "Register")
               nonBot = allContents
            elsif(type != "User")
               nonBot = allContents.select{|content| ((content.user.pouch.privilege != "Bot") && (content.user.pouch.privilege != "Trial")) && ((content.user.pouch.privilege != "Admin") && (content.user.pouch.privilege != "Glitchy"))}
            else
               nonBot = allContents.select{|content| ((content.pouch.privilege != "Bot") && (content.pouch.privilege != "Trial")) && ((content.pouch.privilege != "Admin") && (content.pouch.privilege != "Glitchy"))}
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
         end
         return total
      end

      def getStatDifference(type, visit)
         value = (currentTime - visit.created_on)
         return value
      end

      def getVisitStats(type, timeframe)
         allVisits = ""
         if(type == "User")
            #allVisits = Uservisit.all
         elsif(type == "Radio")
            #allVisits = Radiovisit.all
         elsif(type == "Sound")
            #allVisits = Soundvisit.all
         elsif(type == "Gallery")
            #allVisits = Galleryvisit.all
         elsif(type == "Art")
            #allVisits = Artvisit.all
         elsif(type == "Channel")
            #allVisits = Channelvisit.all
         elsif(type == "Movie")
            #allVisits = Movievisit.all
         elsif(type == "Blog")
            #allVisits = Blogvisit.all
         elsif(type == "OC")
            #allVisits = Ocvisit.all
         elsif(type == "Item")
            #allVisits = Itemvisit.all
         elsif(type == "Creature")
            #allVisits = Creaturevisit.all
         end

         total = 0
         if(allVisits.to_s != "")
            #Determine if the visits is not bot related
            nonBot = allVisits.select{|visit| ((visit.from_user.pouch.privilege != "Bot") && (visit.from_user.pouch.privilege != "Trial")) && ((visit.from_user.pouch.privilege != "Admin") && (visit.from_user.pouch.privilege != "Glitchy"))}

            #Finds all the visit created on a specific time
            twenty = nonBot.select{|visit| getStatDifference(type, visit) <= 20.minutes}
            fourty = nonBot.select{|visit| getStatDifference(type, visit) <= 40.minutes}
            sixty = nonBot.select{|visit| getStatDifference(type, visit) <= 1.hour}
            twohours = nonBot.select{|visit| getStatDifference(type, visit) <= 2.hours}
            threehours = nonBot.select{|visit| getStatDifference(type, visit) <= 3.hours}

            #Sums up the data for the particular timeframe
            twentyCount = twenty.count
            fourtyCount = fourty.count - twentyCount
            sixtyCount = sixty.count - fourtyCount - twentyCount
            twohoursCount = twohours.count - sixtyCount - fourtyCount - twentyCount
            threehoursCount = threehours.count - twohoursCount - sixtyCount - fourtyCount - twentyCount

            total = twentyCount
            if(timeframe == "Fourty")
               total = fourtyCount
            elsif(timeframe == "Sixty")
               total = sixtyCount
            elsif(timeframe == "Twohours")
               total = twohoursCount
            elsif(timeframe == "Threehours")
               total = threehoursCount
            elsif(timeframe == "All")
               total = nonBot.count
            end
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
            value = "[Chipmunks have ran off with the ram]"
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
            elsif(type == "activeusers")
               allMode = Maintenancemode.find_by_id(1)
               if(allMode.maintenance_on)
                  render "/start/maintenance"
               else
                  if(current_user)
                     #Retrieving the active users
                     allUsers = Pouch.order("signed_in_at desc")
                     activeUsers = allUsers.select{|pouch| (pouch.activated && !pouch.signed_out_at) && (pouch.last_visited && (currentTime - pouch.last_visited) < 30.minutes)}
                     @pouches = Kaminari.paginate_array(activeUsers).page(params[:page]).per(50)
                  else
                     redirect_to root_path
                  end
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
               elsif(params[:pageType] == "Creature")
                  redirect_to new_user_creature_path(current_user)
               elsif(params[:pageType] == "Item")
                  redirect_to new_user_item_path(current_user)
               elsif(params[:pageType] == "Usermain")
                  redirect_to user_path(current_user)
               elsif(params[:pageType] == "Colormain")
                  redirect_to colorschemes_maintenance_path
               elsif(params[:pageType] == "Blogmain")
                  redirect_to blogs_path
               elsif(params[:pageType] == "OCmain")
                  redirect_to ocs_path
               elsif(params[:pageType] == "Itemmain")
                  redirect_to items_path
               elsif(params[:pageType] == "Creaturemain")
                  redirect_to creatures_path
               elsif(params[:pageType] == "Jukebox")
                  redirect_to user_jukeboxes_path(current_user)
               end
            elsif(type == "admincontrols" || type == "keymastercontrols" || type == "reviewercontrols" || type == "managercontrols")
            end
         end
      end
end
