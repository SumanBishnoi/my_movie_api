# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, options={})
    render json: {
      status: { success: true, code: 200 , message: "User signed in successfully" ,
        data: current_user }
    }, status: :ok
  end

  #signing out 
  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: { success: true,
        status: 200,
        message: "Signed out successsfully"
      }, status: :ok
    else
      render json: { success: false,
        status: 401,
        message: "User has no active session"
      }, status: :unauthorized
    end
  end
end