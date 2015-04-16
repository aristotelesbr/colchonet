class UserSessionsController < ApplicationController
	def new
		@user_session = UserSession.new(session)
	end

	def create
		if @user_session.authenticate!
			redirect_to root_path, notice: t('flash.notice.signed_in')
		else
			render :new
		end
	end
end