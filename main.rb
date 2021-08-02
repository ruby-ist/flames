require 'sinatra'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-types'
require 'bcrypt'
load 'flames.rb'
load 'quotes.rb'

configure :development do
	DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/flames.db")
end

configure :production do
	DataMapper.setup(:default,ENV["DATABASE_URL"])
end

class Admin
	include DataMapper::Resource
	property :id, Serial
	property :password, BCryptHash
end

DataMapper.finalize.auto_upgrade!

class Lovers
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :required => true, :format => /^[a-zA-Z\s]*$/ 
	property :crushName, String, :required => true, :format => /^[a-zA-Z\s]*$/
	property :result, String
end

DataMapper.finalize.auto_upgrade!

enable :sessions

get "/" do
	erb :index
end

post "/" do
	person = Lovers.new
	person.name = params[:name]
	person.crushName = params[:crushName]

	if person.name == "" || person.crushName == ""
		redirect "/", flash[:error] = "Boxes are empty!"
	elsif person.name == person.crushName
		redirect "/", flash[:error] = "Love youself, no matter what!"
	end

	person.result = flames params[:name], params[:crushName]

	if person.result == "x"
		redirect "/", flash[:error] = "Flames had a choke processing what you juzt entered!"
	end
	
	if person.save
		redirect "/#{person.id}"
	else
	 	redirect "/", flash[:error] = "Invalid names!"
	end
end

get "/admin" do
	if session[:admin]
		@lovers = Lovers.all
		erb :admin
	else
		erb :login
	end
end

post "/admin" do
	if Admin.all == []
		admin = Admin.new
		admin.password = params[:password]
		admin.save
	end
	
	admin = Admin.first
	if admin.password == params[:password]
		session[:admin] = true
		redirect "/admin"
	end

	redirect "/admin", flash[:notice] = "Invalid password"
end

get "/logout" do
	session.clear
	redirect "/"
end

get "/:id" do
	@person = Lovers.get params[:id]
	@answer = expand @person.result
	@quote = quotes[@person.result].sample
	if @answer != nil
		erb :result
	else
		redirect "/"
	end
end


