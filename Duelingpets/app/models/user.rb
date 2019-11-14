class User < ApplicationRecord
   has_many :colorschemes, :foreign_key => "user_id", :dependent => :destroy
   has_one :accounttype, :foreign_key => "user_id", :dependent => :destroy
   has_one :pouch, :foreign_key => "user_id", :dependent => :destroy
   has_one :userinfo, :foreign_key => "user_id", :dependent => :destroy
   has_one :gameinfo, :foreign_key => "user_id", :dependent => :destroy
   has_one :shoutbox, :foreign_key => "user_id", :dependent => :destroy
   has_one :inventory, :foreign_key => "user_id", :dependent => :destroy
   has_many :blogs, :foreign_key => "user_id", :dependent => :destroy
   has_many :economies, :foreign_key => "user_id", :dependent => :destroy
   has_many :suspendedtimelimits, :foreign_key => "user_id", :dependent => :destroy
   has_many :ocs, :foreign_key => "user_id", :dependent => :destroy
   has_many :shouts, :foreign_key => "user_id", :dependent => :destroy

   #Regex code for managing the user section
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9]+\z/i
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z0-9\d\-.]+\.[a-z0-9]+\z/i
   VALID_VNAME_REGEX = /\A[a-z][a-z][a-z][a-z0-9-]+\z/i

   #Validates the user information upon submission
   validates :firstname, presence: true, format: {with: VALID_NAME_REGEX}
   validates :lastname, presence: true, format: {with: VALID_NAME_REGEX}
   validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
   validates :country, presence: true, format: {with: VALID_NAME_REGEX}
   validates :country_timezone, presence: true
   validates :birthday, presence: true
   validates :vname, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :login_id, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :password, length: {minimum: 6}
   validates :password_confirmation, presence: true

   #Saving parameters that get changed
   has_secure_password
   before_save {|user| user.firstname = user.firstname.humanize}
   before_save {|user| user.lastname = user.lastname.humanize}
   before_save {|user| user.email = user.email.downcase}

   #Overides the default parameters to use vname in place of the id code
   def to_param
      self.vname.parameterize
   end
end
