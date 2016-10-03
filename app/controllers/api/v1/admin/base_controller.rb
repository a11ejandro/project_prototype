class Api::V1::Admin::BaseController < Api::V1::BaseController
  before_action :authenticate_admin

  private

  def authenticate_admin
    token = request.headers['HTTP_AUTH_TOKEN'] || params[:auth_token] || request.headers['auth-token']
    @current_device = Device.find_by(auth_token: token)
    @authenticated_admin = @current_device.try(:user)
    render_fail(401, BASE_ERRORS[:invalid_token]) unless @authenticated_admin.try(:admin?)
  end
end