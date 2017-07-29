class ApplicationController < ActionController::Base
	include SessionsHelper
	before_action :authenticated? 
  protect_from_forgery with: :exception



	private
  	def authenticated?
  		redirect_to root_url unless logged_in?
 	  end

end
