module AccounttypesHelper
   private
      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  #removeTransactions
                  allAcounts = Accounttype.order("id asc")
                  @accounttypes = allAccounts
               else
                  redirect_to root_path
               end
            end
         end
      end
end
