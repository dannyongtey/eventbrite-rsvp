module SessionsHelper

	def log_in
		session[:access_token] = ENV["secure_cookies"]
	end

	def logged_in?
		session[:access_token] == ENV["secure_cookies"]
	end

	def log_out
		session.delete(:access_token)
	end

end



