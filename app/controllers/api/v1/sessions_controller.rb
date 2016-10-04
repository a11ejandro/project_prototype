class Api::V1::SessionsController < Api::V1::BaseController
  include Api::V1::SessionsDoc

  before_action :authorize_token, except: [:sign_up, :sign_in]

  def sign_up
    email = params[:email].downcase if params[:email]
    @authenticated_user = User.new(email: email, password: params[:password], role: REGULAR_USER)
    if @authenticated_user.valid?
      @authenticated_user.save
      save_device
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
      save_device
      render locals: { user: @authenticated_user, device: @current_device }
    else
      render_fail(107, BASE_ERRORS[:invalid_credentials])
    end
  end

  def sign_out
    # User can have multiple web sessions
    @current_device.try(:destroy) unless @current_device.is_web?
    render_success(200, {user_logged_out: true})
  end

  private

  def save_device
    @current_device = @authenticated_user.devices.find_by(platform: params[:platform], token: params[:device_token])

    unless @current_device
      @current_device = @authenticated_user.devices.build(platform: params[:platform], token: params[:device_token])
    end

    if @current_device.valid?
      @current_device.save
    else
      case
        when @current_device.errors.messages.include?(:token)
          render_fail(113, "Token can't be blank")
        when @current_device.errors.messages.include?(:platform)
          render_fail(114, "Platform can't be blank")
        else
          render_fail(500, BASE_ERRORS[:internal_error])
      end
    end
  end
end