require 'sinatra'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

require 'sinatra/activerecord'
require 'bcrypt'
load 'flames.rb'
load 'quotes.rb'

set :database_file, "config/database.yml"

class Admin < ActiveRecord::Base
    include BCrypt

    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end
end

class Lovers < ActiveRecord::Base
    validates :name, presence: true, format: {with: /\A[a-zA-Z\s]*\z/}
    validates :crush_name, presence: true, format: {with: /\A[a-zA-Z\s]*\z/}
end


enable :sessions

get "/" do
	erb :index
end

post "/" do
	person = Lovers.new
	person.name = params[:name]
	person.crush_name = params[:crushName]

	if person.name == "" || person.crush_name == ""
		redirect "/", flash[:error] = "Boxes are empty!"
	elsif person.name == person.crush_name
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
	@person = Lovers.find params[:id]
	@answer = expand @person.result
	@quote = quotes[@person.result].sample
	if @answer != nil
		erb :result
	else
		redirect "/"
	end
end


