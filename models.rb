# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# When using Active Record, our program makes some assumptions 
# about our database.
# 
# Model class names are singular. 
# The singular model name refers to pluralized table name:
#
#    - "Users" model refers to "users" table
#    - "Relationship" model refers to "relationships" table
#    - "Twizzle" model refers to "twizzles" table
#    - "Group" model refers to "groups" table
#    - "UserGroup" model refers to "user_groups" table

# If the class name includes multiple words that begin with
# capital letters, the words will be separated by underscores 
# in the table name.
#
# Active Record also assumes that each table has an automatically 
# incremented integer primary key column named id.
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# The User class below gives us the ability to track many-to-many
# associations between users through one "relationships" table. 
#
# Unlike symmetric Facebook-style friendships, 
# which are always reciprocal (at least at the data-model level), 
# Twitter-style following relationships are potentially asymmetric.
# Calvin can follow Hobbes without Hobbes following Calvin. 
# To distinguish between these two cases, we’ll adopt the terminology of 
# active and passive relationships: if Calvin is following Hobbes 
# but not vice versa, Calvin has an active relationship with Hobbes and 
# Hobbes has a passive relationship with Calvin.
# 
# We accomplish this by referring to two columns in the "relationships"
# table called "follower_id" and "following_id". We are specifying that 
# these are the forgein keys used to differentiate between active and 
# passive relationships.

# The has_many :through construct refers to an association, not a table. 
# The :source is a relationship in the class that that association refers to.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class User < ActiveRecord::Base
	has_many :twizzles, dependent: :destroy
	has_many :active_relationships,  class_name:  "Relationship",
		foreign_key: "follower_id",
		dependent:   :destroy
	has_many :passive_relationships, class_name:  "Relationship",
		foreign_key: "followed_id",
		dependent:   :destroy
	has_many :following, through: :active_relationships,  source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	has_many :user_groups
	has_many :groups, :through => :user_groups

	def feed
		following_ids = "SELECT followed_id FROM relationships
			WHERE  follower_id = :user_id"
		Twizzle.where("user_id IN (#{following_ids})
			OR user_id = :user_id", user_id: id)
	end

	def full_name
		if !fname.nil? && !lname.nil?
			fname + " " + lname
		elsif !fname.nil?
      		fname
		elsif !lname.nil?
			lname
		end
	end

end

class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
end

class Twizzle < ActiveRecord::Base
	belongs_to :user

	# This method allows me to output the username of a Twizzle
	# user while looping through Twizzles with "twizzler.username"
	def username
		user.username
	end

	# This method allows me to concatenate the first name and last
	# name of a Twizzle user and output it as "user.full_name" 
	def full_name
		if !user.fname.nil? && !user.lname.nil?
			user.fname + " " + user.lname
		elsif !user.fname.nil?
      		user.fname
		elsif !user.lname.nil?
			user.lname
		end
	end

end

class Group < ActiveRecord::Base
	has_many :user_groups
	has_many :users, :through => :user_groups
end

class UserGroup < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
end