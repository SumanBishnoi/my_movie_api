# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({Success: true}, location: after_sending_reset_password_instructions_path_for(resource_name))
      
    else
      respond_with(resource)
    end
  end
  
  
  
  
  
  private

  def respond_with(resource, options={})
   
    if resource[:Success]
      render json: {
        status: { success: true, code: 200 , message: 'Please check your mail to reset your password ' , 
          data: resource }
          }, status: :ok
    else
      render json: {
        status: { success: false, message: 'User not found' ,
        errors: resource.errors.full_messages }
        }, status: :unprocessable_entity
    end
  
  end




  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
