module Api::V1::Admin::UsersDoc

  extend ActiveSupport::Concern
  
  included do
    swagger_controller :users, "Manage users resource via ADMIN panel"

    swagger_api :update do
      summary 'Update existing User'
      param :path, :id, :integer, :required, 'Id of the user'
      param :form, :first_name, :string, :optional, "User's first name"
      param :form, :last_name, :string, :optional, "User's last name"
      param :form, :email, :string, :optional, "User's Email address"
      param :form, :password, :string, :required, 'Current password'
      param :header, 'rest-token', :string, :required, 'REST token of authenticated admin'

      response :ok, 'Success'
      response 104, "Email can't be blank and/or this email has already been taken"
      response 401, BASE_ERRORS[:invalid_token]
      response 405, BASE_ERRORS[:no_edit_permissions]
      response 403, 'Wrong password confirmation'
    end

    swagger_api :reset_password do
      summary 'Recover user password'
      param :query, :email, :string, :required, 'Email of the user'
      response :ok, 'Success'
      response 404, 'No user with such credentials'
    end

    swagger_api :show do
      summary "Show user profile"
      param :path, :id, :integer, :required, 'Id of the user'
      param :header, 'rest-token', :string, :required, 'REST token of authenticated admin'
      response :ok, 'Success'
      response 404, 'No user with such credentials'
      response 401, BASE_ERRORS[:invalid_token]
    end

    swagger_api :destroy do
      summary "Destroy user profile"
      param :path, :id, :integer, :required, 'Id of the user'
      param :header, 'rest-token', :string, :required, 'REST token of authenticated admin'
      response :ok, 'Success'
      response 404, 'No user with such credentials'
      response 401, BASE_ERRORS[:invalid_token]
    end

    swagger_api :index do
      summary "List and filter users"

      param :header, 'rest-token', :string, :required, 'REST token of authenticated admin'
      param :form, :search_phrase, :string, :optional, 'String to search for in user fields'
      param :form, :sort_field, :string, :optional, 'Field, which values will be sorted'
      param_list :form, :sort_order, :string, :optional, 'Sort order', %w(ASC DESC)
    end
  end
end