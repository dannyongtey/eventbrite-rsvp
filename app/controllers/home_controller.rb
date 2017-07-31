class HomeController < ApplicationController
	skip_before_action :authenticated?, only: [:index, :login, :landing, :update]
	before_action :check_authentication, only: :index

	def index
		
	end

	def landing
		@message = params[:message]
		@full_params = params
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

	def update
		message = params[:message][:content]
		email = params[:email]
		token = params[:token]
		event_uid = params[:event_uid]
	end

	private

		def check_authentication
			if logged_in?
				redirect_to events_path
			end
		end
end
