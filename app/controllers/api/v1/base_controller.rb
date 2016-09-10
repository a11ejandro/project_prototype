class Api::V1::BaseController < ActionController::API
  Swagger::Docs::Generator::set_real_methods
  include Sorcery::Controller

  def render_fail(status_code = 400, description = nil)
    render template: 'common/error', locals: {status: status_code, result: description}
  end

  def render_success(status_code = 200, result = nil)
    render template: 'common/success', locals: {status: status_code, result: result}
  end

  def authorize_rest_token
    token = request.headers['HTTP_REST_TOKEN'] || params[:rest_token] || request.headers['rest-token']
    @authenticated_user = User.find_by(rest_token: token)
    render_fail(401, BASE_ERRORS[:invalid_token]) unless @authenticated_user
  end

  # Compatibility with Sorcery
  def form_authenticity_token
  end
end