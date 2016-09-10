module Api::V1::Admin::SessionsDoc
  
  extend ActiveSupport::Concern

  included do
    swagger_controller :sessions, "Manage ADMIN authorization via email"

    swagger_api :sign_in do
      summary "Perform admin authorization"
      notes "Sign in action. Returns athorized user fields as json"
      param :form, :email,    :string, :required, "User's email"
      param :form, :password, :string, :required, "User's password"
      response :ok, "Success"
      response 401, BASE_ERRORS[:invalid_credentials]
      response 107, BASE_ERRORS[:invalid_credentials]
    end

    swagger_api :sign_out do
      summary "Log admin out"
      notes "Log admin out from the app"
      param :header, 'rest-token',   :string, :required, 'REST token of the admin which we want to log out'
      response :ok, 'Success'
      response 401, BASE_ERRORS[:invalid_token]
    end
  end
end