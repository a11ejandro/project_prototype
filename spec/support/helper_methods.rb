module Support
  module HelperMethods
    def json
      JSON.parse(response.body)
    end

    def get_token(user=nil, auth_path = 'sign_in')
      @user = user || FactoryGirl.create(:user)
      post auth_path, params: {email: @user.email, password: 'password', format: :json}

      @rest_token = json['result']['rest_token']
    end
  end
end