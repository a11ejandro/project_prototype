module Api::V1::SessionsDoc 
  
  extend ActiveSupport::Concern

  included do
    swagger_controller :sessions, "Manage user registration/authorization via email"

    swagger_api :sign_up do
      summary 'Perform user registration'
      notes 'Creates new user using passed params. Returns created user fields as json'
      param :form, :email,         :string, :required, "User's email"
      param :form, :password,      :string, :required, "User's password, 6 characters minimum."
      param :form, :first_name,    :string, :optional, "User's first name"
      param :form, :last_name,    :string, :optional, "User's last name"
      response :ok, 'Success'
      response 103, "#{USER_ERROR_MESSAGES[:first_name][:presence]} or #{USER_ERROR_MESSAGES[:last_name][:presence]}"
      response 104, "Email can't be blank and/or this email has already been taken and/or email is invalid"
      response 105, USER_ERROR_MESSAGES[:password][:presence]
      response 111, USER_ERROR_MESSAGES[:referral_code][:validity]
      response 500, BASE_ERRORS[:internal_error]
    end

    swagger_api :sign_in do
      summary "Perform user authorization"
      notes "Sign in action. Returns athorized user fields as json"
      param :form, :email,    :string, :required, "User's email"
      param :form, :password, :string, :required, "User's password"
      response :ok, "Success"
      response 112, BASE_ERRORS[:user_blocked]
      response 107, BASE_ERRORS[:invalid_credentials]
    end

    swagger_api :sign_out do
      summary "Log user out"
      notes "Log user out from the app"
      param :header, 'rest-token',   :string, :required, "REST token of the user which we want to log out"
      response :ok, "Success"
      response 401, BASE_ERRORS[:invalid_token]
    end
  end
end