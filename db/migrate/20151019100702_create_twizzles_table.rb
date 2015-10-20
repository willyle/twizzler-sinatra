class CreateTwizzlesTable < ActiveRecord::Migration
	def change
		create_table :twizzles do |t|
			t.integer :user_id
			t.string :content
			t.string :created_at
			t.string :updated_at
		end	
	end	
end		