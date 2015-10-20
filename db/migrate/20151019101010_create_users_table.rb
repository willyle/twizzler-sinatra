class CreateUsersTable < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username
			t.string :fname
			t.string :lname
			t.string :headline
			t.string :email
			t.string :password		
		end	
	end	
end		