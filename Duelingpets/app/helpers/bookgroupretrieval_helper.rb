module BookgroupretrievalHelper

   private
      def getReadingGroup(user, type)
         group = user.userinfo.bookgroup_id
         if(type == "Name")
            group = user.userinfo.bookgroup.name
         end
         return group
      end

      def getWritingGroup(user, type)
         groupValue = ""
         age = (currentTime.year - user.birthday.year)
         month = (currentTime.month - user.birthday.month) / 12
         if(month < 0)
            age -= 1
         end

         #Determines the group
         if(age < 7)
            groupValue = 0
         elsif(age < 13)
            groupValue = 1
         elsif(age < 19)
            groupValue = 2
         elsif(age < 25)
            groupValue = 3
         elsif(age < 31)
            groupValue = 4
         elsif(age < 37)
            groupValue = 5
         elsif(age >= 37)
            groupValue = 6
         end
         if(type == "Name")
            if(groupValue > 0)
               bookgroup = Bookgroup.find_by_id(groupValue)
               groupValue = bookgroup.name
            else
               groupValue = "Lizardo"
            end
         end
         return groupValue
      end

      def getBookGroups(name)
         allUsers = User.all
         currentDate = Date.today
         nonBot = allUsers.select{|user| ((user.pouch.privilege != "Bot") && (user.pouch.privilege != "Trial")) && (user.pouch.privilege != "Admin")}

         #Group values
         lizardo = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) < 7.years}
         rabbit = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) < 13.years}
         blueland = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) < 19.years}
         dragon = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) < 25.years}
         silverwing = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) < 31.years}
         harahpin = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) < 37.years}
         rings = nonBot.select{|user| (currentDate.to_time - user.birthday.to_time) >= 37.years}

         #Count values
         rabbitCount = rabbit.count - lizardo.count
         bluelandCount = blueland.count - rabbitCount - lizardo.count
         dragonCount = dragon.count - bluelandCount - rabbitCount - lizardo.count
         silverwingCount = silverwing.count - dragonCount - bluelandCount - rabbitCount - lizardo.count
         harahpinCount = harahpin.count - silverwingCount - dragonCount - bluelandCount - rabbitCount - lizardo.count
         ringsCount = rings.count
 
         value = 0
         if(name == "Rabbit")
            value = rabbitCount
         elsif(name == "Blueland")
            value = bluelandCount
         elsif(name == "Dragon")
            value = dragonCount
         elsif(name == "Silverwing")
            value = silverwingCount
         elsif(name == "Harahpin")
            value = harahpinCount
         elsif(name == "Rings")
            value = ringsCount
         end
         return value
      end
end
