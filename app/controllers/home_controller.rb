class HomeController < ApplicationController
	skip_before_action :authenticated?, only: [:index, :login]
	before_action :check_authentication, only: :index

	def index
		@message = params[:message]
	end

	def login
		password = params[:login][:password]
		if password == ENV['access_password']
			log_in
			redirect_to events_path
		else
			flash[:danger] = "Wrong access password."
			redirect_to root_url
		end
	end

	def logout
		log_out
		redirect_to root_path
	end

	private

		def check_authentication
			if logged_in?
				redirect_to events_path
			end
		end
end
