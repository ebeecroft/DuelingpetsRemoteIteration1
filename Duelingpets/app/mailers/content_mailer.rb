class ContentMailer < ApplicationMailer

   def content_created(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Colorscheme")
         email = content.user.email
         message = "Your colorscheme #{content.name} was created:[Duelingpets]"
      elsif(type == "Watch")
         email = content.to_user.email
         message = "#{content.from_user.vname} is now watching you:[Duelingpets]"
      elsif(type == "Referral")
         email = content.referred_by.email
         message = "#{content.to_user.vname} was referred by you:[Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_approved(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Blog")
         email = content.user.email
         message = "Your blog #{content.title} was approved:[Duelingpets]"
      elsif(type == "OC")
         email = content.user.email
         message = "Your oc #{content.name} was approved:[Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_denied(content, type)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Blog")
         email = content.user.email
         message = "Your blog #{content.title} was denied:[Duelingpets]"
      elsif(type == "OC")
         email = content.user.email
         message = "Your oc #{content.name} was denied:[Duelingpets]"
      end
      @type = type
      @content = content
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_review(content, type, url)
      message = ""
      if(type == "Blog")
         message = "New blog #{content.title} is awaiting review:[Duelingpets]"
      elsif(type == "OC")
         message = "New oc #{content.name} is awaiting review:[Duelingpets]"
      end
      @type = type
      @content = content
      @url = url
      emailStaff(message)
   end

   def emailStaff(message)
      websiteMail = "notification@duelingpets.net"
      allPouches = Pouch.all
      mods = allPouches.select{|pouch| (pouch.privilege == "Keymaster" || pouch.privilege == "Reviewer")}
      if(mods.count > 0)
         mods.each do |staff|
            mail(to: staff.user.email, from: websiteMail, subject: message)
         end
      end
   end
end
