module CusersHelper

   private
      def displayGreeter(name)
         contentFound = Artpage.find_by_name(name)
         @artpage = contentFound
      end

      #Combine these three
      def displayName(user)
         name = ""
         if(current_user && (current_user.pouch.privilege == "Admin" || current_user.id == user.id))
            name = (user.firstname + " " + user.lastname)
         else
            name = user.firstname
         end
         return name
      end

      def displayBirthday(user)
         birthday = ""
         if(current_user && (current_user.pouch.privilege == "Admin" || current_user.id == user.id))
            birthday = user.birthday.strftime("%B-%d-%Y")
         else
            birthday = user.birthday.strftime("%B-%d")
         end
         return birthday
      end

      def displayVname(user)
         vname = ""
         if(current_user)
            vname = user.vname + " joined on: " + user.joined_on.strftime("%B-%d-%Y")
         else
            vname = user.vname
         end
         return vname
      end

      #Combine ends

      def playMusicLoop(type, user)
         sound = ""
         control = Webcontrol.find_by_id(1)
         if(!current_user.userinfo.mute_on)
            if(current_user.userinfo.audiobrowser == "ogg")
               if(type == "Maintenance")
                  sound = (audio_tag(getMusicOrVideo("Maintenance", control.maintenanceogg_url), :loop => true, :autoplay => true))
               elsif(type == "Missing")
                  sound = (audio_tag(getMusicOrVideo("Missing", control.missingpageogg_url), :loop => true, :autoplay => true))
               elsif(type == "Hoard")
                  dragonhoard = Dragonhoard.find_by_id(1)
                  sound = (audio_tag(getMusicOrVideo("Sound", dragonhoard), :loop => true, :autoplay => true))
               elsif(type == "User")
                  if(user.userinfo.music_on)
                     sound = (audio_tag(getMusicOrVideo("User", user), :loop => true, :autoplay => true))
                  end
               elsif(type == "Creative")
                  sound = (audio_tag(getMusicOrVideo("Creative", control.creationogg_url), :loop => true, :autoplay => true))
               elsif(type == "Homepage")
                  criticalMode = Maintenancemode.find_by_id(2)
                  betaMode = Maintenancemode.find_by_id(3)
                  grandMode = Maintenancemode.find_by_id(4)

                  #Plays the appropriate homepage music
                  sound = (audio_tag(getMusicOrVideo("Homepage", control.ogg_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  if(criticalMode.maintenance_on)
                     sound = (audio_tag(getMusicOrVideo("Homepage", control.criticalogg_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  elsif(betaMode.maintenance_on)
                     sound = (audio_tag(getMusicOrVideo("Homepage", control.betaogg_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  elsif(grandMode.maintenance_on)
                     sound = (audio_tag(getMusicOrVideo("Homepage", control.grandogg_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  end
               end
            elsif(current_user.userinfo.audiobrowser == "mp3")
               if(type == "Maintenance")
                  sound = (audio_tag(getMusicOrVideo("Maintenance", control.maintenancemp3_url), :loop => true, :autoplay => true))
               elsif(type == "Missing")
                  sound = (audio_tag(getMusicOrVideo("Missing", control.missingpagemp3_url), :loop => true, :autoplay => true))
               elsif(type == "Hoard")
                  dragonhoard = Dragonhoard.find_by_id(1)
                  sound = (audio_tag(getMusicOrVideo("Sound", dragonhoard), :loop => true, :autoplay => true))
               elsif(type == "User")
                  if(user.userinfo.music_on)
                     sound = (audio_tag(getMusicOrVideo("User", user), :loop => true, :autoplay => true))
                  end
               elsif(type == "Creative")
                  sound = (audio_tag(getMusicOrVideo("Creative", control.creationmp3_url), :loop => true, :autoplay => true))
               elsif(type == "Homepage")
                  criticalMode = Maintenancemode.find_by_id(2)
                  betaMode = Maintenancemode.find_by_id(3)
                  grandMode = Maintenancemode.find_by_id(4)

                  #Plays the appropriate homepage music
                  sound = (audio_tag(getMusicOrVideo("Homepage", control.mp3_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  if(criticalMode.maintenance_on)
                     sound = (audio_tag(getMusicOrVideo("Homepage", control.criticalmp3_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  elsif(betaMode.maintenance_on)
                     sound = (audio_tag(getMusicOrVideo("Homepage", control.betamp3_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  elsif(grandMode.maintenance_on)
                     sound = (audio_tag(getMusicOrVideo("Homepage", control.grandmp3_url), :controls => true, :hidden => true, :loop => true, :autoplay => true))
                  end
               end
            else
               raise "Invalid browser setting detected! Please choose mp3 or ogg"
            end
         end
         #return sound
      end

      def getUserPrivilege(user)
         if(user.pouch.privilege == "Admin")
            value = "@"
         else
            pouchFound = Pouch.find_by_user_id(user.id)
            if(pouchFound)
               type = pouchFound.privilege
               if(type == "Keymaster")
                  value = "$"
               elsif(type == "Reviewer")
                  value = "^"
               elsif(type == "Beta")
                  value = "%"
               elsif(type == "Banned")
                  value = "!"
               elsif(type == "Trial")
                  value = "?"
               else
                  value = "~"
               end
            else
               value = "~"
            end
         end
         return value
      end

      def getUserStatus(status)
         allPouches = Pouch.all

         #Status value
         activatedUsers = allPouches.select{|pouch| pouch.activated && ((pouch.privilege != "Bot" && pouch.privilege != "Trial") && (pouch.privilege != "Admin" && pouch.privilege != "Glitchy"))}
         
         onlineUsers = activatedUsers.select{|pouch| !pouch.signed_out_at && (pouch.last_visited && (currentTime - pouch.last_visited) < 30.minutes)}
         inactiveUsers = activatedUsers.select{|pouch| !pouch.signed_out_at && (pouch.last_visited && (currentTime - pouch.last_visited) >= 30.minutes)}
         offlineUsers = activatedUsers.select{|pouch| (pouch.signed_in_at && pouch.signed_out_at) && !pouch.gone}
         goneUsers = activatedUsers.select{|pouch| (pouch.signed_in_at && pouch.signed_out_at) && pouch.gone}
         bots = allPouches.select{|pouch| !pouch.activated}

         #Count values
         onlineCount = onlineUsers.count
         inactiveCount = inactiveUsers.count
         offlineCount = offlineUsers.count
         goneCount = goneUsers.count
         botCount = bots.count

         value = onlineCount
         if(status == "Inactive")
            value = inactiveCount
         elsif(status == "Offline")
            value = offlineCount
         elsif(status == "Gone")
            value = goneCount
         elsif(status == "Bots")
            value = botCount
         end
         return value
      end

      def newestContent(type)
         allContents = ""

         #Determines the correct type of content to display
         if(type == "Art")
            allContents = Art.order("created_on desc")
         elsif(type == "Movie")
            allContents = Movie.order("created_on desc")
         elsif(type == "Sound")
            allContents = Sound.order("created_on desc")
         elsif(type == "Book")
            allContents = Book.order("created_on desc")
         elsif(type == "OC")
            allContents = Oc.order("created_on desc")
         elsif(type == "Item")
            allContents = Item.order("created_on desc")
         else
            raise "Invalid content type detected!"
         end
         if(type != "Item")
            reviewedContents = allContents.select{|content| content.reviewed && checkBookgroupStatus(content)}
         else
            reviewedContents = allContents.select{|content| content.reviewed}
         end
         contents = reviewedContents.take(3)
         return contents
      end

      def checkBookgroupStatus(content)
         group = ((content.bookgroup.name == "Peter-Rabbit") || (current_user && content.bookgroup.id <= getReadingGroup(current_user, "Id")))
         return group
      end

      def getMusicOrVideo(type, content)
         music = ""
         if(current_user)
            #Determine if we are looking at a video or audio browser
            oggbrowser = (current_user.userinfo.audiobrowser == "ogg")
            if(type == "Movie")
               oggbrowser = (current_user.userinfo.videobrowser == "ogv")
            end

            #Determine if we are looking at a video or audio browser
            mp3browser = (current_user.userinfo.audiobrowser == "mp3")
            if(type == "Movie")
               mp3browser = (current_user.userinfo.videobrowser == "mp4")
            end

            #Determines the correct type of content to play
            if(oggbrowser)
               music = ""
               if(type == "User")
                  music = content.userinfo.ogg_url
               elsif(type == "Movie")
                  music = content.ogv_url
               elsif(type == "Sound")
                  music = content.ogg_url
               elsif((type != "User" && type != "Movie") && (type != "Sound"))
                  music = content
               end
            elsif(mp3browser)
               music = ""
               if(type == "User")
                  music = content.userinfo.mp3_url
               elsif(type == "Movie")
                  music = content.mp4_url
               elsif(type == "Sound")
                  music = content.mp3_url
               elsif((type != "User" && type != "Movie") && (type != "Sound"))
                  music = content
               end
            end
         else
            #Determines the content to play for guests
            music = ""
            if(type == "User")
               music = content.userinfo.ogg_url
            elsif(type == "Movie")
               music = content.ogv_url
            elsif(type == "Sound")
               music = content.ogg_url
            elsif((type != "User" && type != "Movie") && (type != "Sound"))
               music = content
            end
         end
         return music
      end

      def logout_user
         if(current_user)
            flash[:success] = "Don't worry #{current_user.vname} we will await your return."
            resetExpiretime(current_user)
            cookies.delete(:remember_token)
            self.current_user = nil
         else
            flash[:error] = "You are already logged out of the system!"
         end
      end

      def logoutExpiredUsers
         allUsers = User.order("joined_on desc")
         users = allUsers.select{|user| !user.pouch.expiretime.nil? && (currentTime >= user.pouch.expiretime)}
         if(users.count > 0)
            users.each do |user|
               resetExpiretime(user)
            end
         end
      end

      def resetExpiretime(user)
         userPouch = Pouch.find_by_user_id(user.id)
         userPouch.remember_token = "NULL"
         userPouch.last_visited = nil
         value = currentTime
         if(timeExpired)
            value = userPouch.expiretime
         end
         userPouch.signed_out_at = value
         userPouch.expiretime = nil
         @pouch = userPouch
         @pouch.save
      end

      def timeExpired
         #Determines if the user has exceed the time limit
         if(current_user)
            userPouch = Pouch.find_by_user_id(current_user.id)
            if(userPouch && !userPouch.expiretime.nil?)
               if(currentTime >= userPouch.expiretime)
                  return true
               else
                  return false
               end
            end
         else
            return false
         end
      end

      def getClock
         if(current_user)
            clockTime = currentTime.in_time_zone(current_user.country_timezone)
            if(current_user.userinfo.militarytime)
               clockTime.strftime("%H:%M:%S %Z")
            else
               clockTime.strftime("%I:%M:%S %p %Z")
            end
         else
            currentTime.strftime("%I:%M:%S %p %Z")
         end
      end

      def currentTime
         Time.zone.now
      end

      def current_user
         userPouch = Pouch.find_by_remember_token(cookies[:remember_token])
         if(userPouch)
            @current_user ||= User.find_by_vname(userPouch.user.vname)
         else
            @current_user
         end
      end

      def current_user=(user)
         @current_user = user
      end

      def removeTransactions
         allTransactions = Economy.order("created_on desc")
         if(allTransactions.count > 0)
            oldTrans = allTransactions.select{|transaction| (currentTime - transaction.created_on) > 12.hours}
            oldTrans.each do |transaction|
               @economytransaction = transaction
               @economytransaction.destroy
            end
         end
      end
end
