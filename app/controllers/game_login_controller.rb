class GameLoginController < ApplicationController
	skip_before_action :preload_json, :check_xhr
	
	def create
		#params.require(:login)
		#params.require(:password)
		return render json: {test: 1}
	end
end