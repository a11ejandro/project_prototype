module Api::V1::UsersDoc 

  extend ActiveSupport::Concern
  
  included do
    swagger_controller :users, "Manage users resource"

    swagger_api :update do
      summary "Update existing User"
      param :path, :id, :integer, :required, "Id of the user"
      param :form, :first_name, :string, :optional, "User's first name"
      param :form, :last_name, :string, :optional, "User's last name"
      param :form, :email, :string, :optional, "User's Email address"
      param :form, :password, :string, :required, 'Current password'
      param :header, 'rest-token', :string, :required, "REST token of the authenticated user"

      response :ok, "Success"
      response 104, "Email can't be blank and/or this email has already been taken"
      response 401, BASE_ERRORS[:invalid_token]
      response 405, BASE_ERRORS[:no_edit_permissions]
      response 403, 'Wrong password confirmation'
    end

    swagger_api :reset_password do
      summary "Recover user password"
      param :query, :email, :string, :required, "Email of the user"
      response :ok, "Success"
      response 404, "No user with such credentials"
    end

    swagger_api :show do
      summary "Show user profile"
      param :path, :id, :integer, :required, "Id of the user"
      param :header, 'rest-token', :string, :required, "REST token of the authenticated user"
      response :ok, "Success"
      response 404, "No user with such credentials"
      response 401, BASE_ERRORS[:invalid_token]
    end

    swagger_api :update_password do
      summary "Change user password"
      notes "Change user password"
      param :query, :old_password, :string, :required, "User's old password"
      param :query, :new_password, :string, :required, "User's new password"
      param :header, 'rest-token',  :string, :required, "REST token of the authenticated user"
      response :ok, "Success"
      response 401, BASE_ERRORS[:invalid_token]
      response 107, BASE_ERRORS[:invalid_credentials]
      response 109, "Need to pass new password"
    end
  end
end