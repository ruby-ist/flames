# frozen_string_literal: true

source "https://rubygems.org"

ruby '2.7.4'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra', "1.4.8"
gem 'sinatra-flash', :require => 'sinatra/flash'
gem 'sinatra-redirect-with-flash', :require => 'sinatra/redirect_with_flash'
gem 'sinatra-activerecord'
gem "rake"
gem 'bcrypt'

gem 'sqlite3', :group => :development
gem 'activerecord-cockroachdb-adapter', :group => :production
gem 'puma', :group => :production
