class ApplicationController < ActionController::Base

helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		rescue ActiveRecord::RecordNotFound
	end

	def logged_in?
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform that action"
		redirect_to root_path
		end
	end

	def send_notification(type, tag, source_user, dest_user, subject1, subject2)
		Notification.create do |notification|
			notification.notify_type = type
			notification.tag = tag
			notification.actor = source_user
			notification.user = dest_user
			notification.target = subject1
			notification.second_target = subject2
		end
	end

end
