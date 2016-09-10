class Api::V1::SessionsController < Api::V1::BaseController
  include Api::V1::SessionsDoc

  before_action :authorize_rest_token, except: [:sign_up, :sign_in]

  def sign_up
    email = params[:email].downcase if params[:email]
    user = User.new(email: email, password: params[:password], role: REGULAR_USER)
    if user.valid?
      user.save
      render_success
    else
      case
        when user.errors.messages.include?(:name)
          render_fail(103, user.errors.messages[:name].first)
        when user.errors.messages.include?(:email)
          render_fail(104, 'Email ' + user.errors.messages[:email].first)
        when user.errors.messages.include?(:password)
          render_fail(105, 'Password ' + user.errors.messages[:password].first)
        else
          render_fail(500, BASE_ERRORS[:internal_error])
      end
    end
  end


  def sign_in
    email = params[:email].downcase if params[:email]
    @authenticated_user = login(email, params[:password])
    if @authenticated_user
      # Invalidate other sessions.
      @authenticated_user.update_rest_token
      render locals: {user: @authenticated_user}
    else
      render_fail(107, BASE_ERRORS[:invalid_credentials])
    end
  end

  def sign_out
    @authenticated_user.update_rest_token
    render_success(200, {user_logged_out: true})
  end
end