class GameUserHasSecondAuthController < ApplicationController
	skip_before_action :preload_json, :check_xhr
	
	def index
		params.require(:login)
		params.require(:api_password)
		
		if params[:api_password] != SiteSetting.server_api_password  # Require password to call this API.
			return render json:{error: "Invalid server-api-password"}
		end
		
		user = User.find_by_username_or_email(normalized_login_param)
		
		if user.present?
			# render json: {success: true, method: user.totps.method}
			render_serialized(user.totps, SecondFactorSerializer)
			return
		else
			render json: {error: "Can not find user with that email/username"}
			return
		end
		
		
	end
	
	def normalized_login_param
		login = params[:login].to_s
		if login.present?
			login = login[1..-1] if login[0] == "@"
			User.normalize_username(login.strip)[0..100]
		else
			nil
		end
	end
end