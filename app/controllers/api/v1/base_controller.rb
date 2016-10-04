class Api::V1::BaseController < ActionController::API
  Swagger::Docs::Generator::set_real_methods
  include Sorcery::Controller


  def render_fail(status_code = 400, description = nil)
    render template: 'common/error', locals: {status: status_code, result: description}
  end

  def render_success(status_code = 200, result = nil)
    render template: 'common/success', locals: {status: status_code, result: result}
  end

  def authorize_token
    token = request.headers['HTTP_AUTH_TOKEN'] || params[:auth_token] || request.headers['auth-token']
    @current_device = Device.find_by(auth_token: token)
    @authenticated_user = @current_device.try(:user)
    render_fail(401, BASE_ERRORS[:invalid_token]) unless @authenticated_user
  end

  # Compatibility with Sorcery
  def form_authenticity_token
  end

end