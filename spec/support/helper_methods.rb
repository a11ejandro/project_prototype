module Support
  module HelperMethods
    def json
      JSON.parse(response.body)
    end

    def get_token(user=nil, auth_path = 'sign_in')
      @user = user || FactoryGirl.create(:user)
      post auth_path, params: {email: @user.email, password: 'password', platform: 'ios', device_token: 'ios-token', format: :json}

      @auth_token = json['result']['auth_token']
    end
  end
end