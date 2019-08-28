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
end
