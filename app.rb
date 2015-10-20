require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'pp'
require './models'
require './environments'

enable :sessions

def current_user
	if session[:session_user_id]
		@current_user = User.find(session[:session_user_id])
	end	
end		

get '/' do
	if session[:session_user_id]
		@user = current_user
		@twizzles = @user.twizzles
		@followers = @user.followers
		@following = @user.following
		@feed = @user.feed
		erb :home
	else	
		erb :login
	end
end

get '/users' do
	if session[:session_user_id]
		@user = current_user
		@twizzles = @user.twizzles
		@followers = @user.followers
		@following = @user.following
	end	
	@groups = Group.all
	@users = User.all
	erb :users
end

get '/profile/:id' do
	@user = User.find(params[:id])
	@me = current_user
	@twizzles = @user.twizzles
	@followers = @user.followers
	@following = @user.following
	if session[:session_user_id]
		@myfollowers = @me.followers
		@myfollowing = @me.following
	end	
	erb :profile
end

get '/followers/:id' do
	@user = User.find(params[:id])
	@me = User.find(current_user.id)
	@twizzles = @user.twizzles
	@followers = @user.followers
	@following = @user.following
	if session[:session_user_id]
		@myfollowers = @me.followers
		@myfollowing = @me.following
	end	
	erb :followers
end

get '/following/:id' do
	@user = User.find(params[:id])
	@me = User.find(current_user.id)
	@twizzles = @user.twizzles
	@followers = @user.followers
	@following = @user.following
	if session[:session_user_id]
		@myfollowers = @me.followers
		@myfollowing = @me.following
	end	
	erb :following
end


get '/group/:id' do
	@users = Group.find(params[:id]).users
	@groups = Group.all
	@group = Group.find(params[:id])
	erb :group
end


get '/login' do
	erb :login
end

post '/signin' do

	@user = User.where(username: params[:username]).first

	if params[:username].empty?
		flash[:alert] = "Username cannot be empty!"
		redirect '/'
	elsif params[:password].empty?
		flash[:alert] = "Password cannot be empty!"
		redirect '/'
	end

	if @user == nil
		flash[:alert] = "This username does not exist"
		redirect '/'
	end
	if @user.password == params[:password]
		session[:session_user_id] = @user.id
		session[:session_username] = @user.username
		flash[:notice] = "You're logged in!"
		redirect '/'
	else
		flash[:alert] = "Password is incorrect!"
		redirect '/'
	end
end

get '/signup' do
	erb :signup
end

post '/signup' do
	
	if params[:username].empty?
		flash[:alert] = "Username cannot be empty!"
		redirect back
	elsif params[:password].empty?
		flash[:alert] = "Password cannot be empty!"
		redirect back
	elsif params[:fname].empty?
		flash[:alert] = "First name cannot be empty!"
		redirect back
	elsif params[:lname].empty?
		flash[:alert] = "Last name cannot be empty!"
		redirect back
	elsif params[:email].empty?
		flash[:alert] = "Email cannot be empty!"
		redirect back
	elsif params[:headline].empty?
		flash[:alert] = "Headline cannot be empty!"
		redirect back
	end

	@user = User.new(username: params[:username], 
		password: params[:password], 
		fname: params[:fname], 
		lname: params[:lname], 
		email: params[:email], 
		headline: params[:headline]
	)
	@user.save
	flash[:notice] = "You're signed up"
	redirect '/'
end

post '/new-twizzle' do
	if params[:twizzle_content].empty?
		flash[:alert] = "Twizzle cannot be empty!"
		redirect back
	end
	@new_tizzle = Twizzle.new
	@new_tizzle.user_id = params[:user_id]
	@new_tizzle.content = params[:twizzle_content]
	@new_tizzle.save
	redirect back
end

post '/delete-twizzle' do
	@twizzle = params[:twizzle_id]
	Twizzle.destroy(@twizzle)
	flash[:notice] = "Your Twizzle has been deleted!"
	redirect back
end

post '/delete-profile' do

	@user = current_user

	if params[:password].empty?
		flash[:alert] = "Password cannot be empty!"
		redirect back
	elsif @user.password == params[:password]
		User.destroy(@user)
		session.clear
		flash[:notice] = "Your Twizzle account been deleted!"
		redirect '/'
	else
		flash[:alert] = "Password was incorrect!"
		redirect back
	end

end

post '/follow' do
	Relationship.create(followed_id: params[:followed_id], follower_id: params[:follower_id])
	@followed_username = params[:followed_username]
	flash[:notice] = "You're now following " + @followed_username + "!"
	redirect back
end

post '/unfollow' do
	Relationship.where("followed_id = #{params[:followed_id]} and follower_id = #{params[:follower_id]}").destroy_all
	@followed_username = params[:followed_username]
	flash[:notice] = "You have unfollowed " + @followed_username + "!"
	redirect '/'
end

get '/logout' do
	session.clear
	flash[:notice] = "You have been logged out!"
	redirect '/'
end

get '/settings/:id' do
	@user = User.find(params[:id])
	erb :settings
end

post '/settings' do
	@user = User.find(session[:session_user_id])
	@user.username = params[:username]
	@user.fname = params[:fname]
	@user.lname = params[:lname]
	@user.headline = params[:headline]
	@user.email = params[:email]
	@user.password = params[:password]
	@user.save
	redirect '/'
end

# Handle GET-request (Show the upload form)
get "/upload" do
	@user = User.find(session[:session_user_id])	
	erb :upload
end      
    
# Handle POST-request (Receive and save the uploaded file)
post "/upload" do 
	File.open('public/uploads/' + params['file'][:filename], "w") do |f|
		f.write(params['file'][:tempfile].read)
	end
	File.rename('public/uploads/' + params['file'][:filename], "public/uploads/" + params[:username] + ".jpg") 
	flash[:alert] = "The image was successfully loaded!"
	redirect '/'
end