class Api::V1::Admin::SessionsController < Api::V1::Admin::BaseController
  include Api::V1::Admin::SessionsDoc

  skip_before_action :authenticate_admin, only: 'sign_in'

  def sign_in
    email = params[:email].downcase if params[:email]
    @authenticated_admin = login(email, params[:password])
    if @authenticated_admin && @authenticated_admin.admin?
      save_device
    else
      render_fail(107, BASE_ERRORS[:invalid_credentials])
    end
  end

  def sign_out
    # Admin has only one web session
    @current_device.destroy
    render_success(200, {admin_logged_out: true})
  end

  private

  def save_device
    @current_device = @authenticated_admin.devices.find_by(platform: params[:platform], token: params[:device_token])

    unless @current_device
      @current_device = @authenticated_admin.devices.build(platform: params[:platform], token: params[:device_token])
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