class SessionsController < ApplicationController
  def create
    puts params.to_yaml
    puts request.env['omniauth.auth'].to_yaml

    json = { warning: 'There was an error while trying to authenticate you...' }
		begin
			user = User.from_omniauth(request.env['omniauth.auth'])
			session[:user_id] = user.id
			json = { success: "Welcome, #{user.name}!" }
		end
		render 'inform_loggingin', layout: false
  end

  def destroy
		current_user && session.delete(:user_id)
		head :ok
	end
end

