module StartHelper

   private
def mode(type)
         a = 3
         if(a == 0)#timeExpired)
            #logout_user
            #logoutExpiredUsers
            #redirect_to root_path
         else
            if(type == "home" || type == "aboutus")
               #Initially empty
               #removeTransactions
            elsif(type == "contact" || type == "verify" || type == "verify2")
               #Consider adding a greater to contact page
               #removeTransactions
               if(type == "verify")
                  color_value = params[:session][:color].downcase
                  if(color_value)
                     results = `/home/eric/Projects/Local/Websites/Resources/Code/verification/verify #{color_value}`
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
                     UserMailer.contact(@name, @email, @subject, @body).deliver_later(wait: 5.minutes)
                  end
                  redirect_to root_path
               end
            elsif(type == "muteAudio")
               value = ""
               if(checkMusicFlag == "On")
                  value = "Off"
               else
                  value = "On"
               end
               cookies[:mute_on] = {:value => value}
               redirect_to root_path
            elsif(type == "admincontrols" || type == "keymastercontrols" || type == "reviewercontrols")
            end
         end
      end
end
