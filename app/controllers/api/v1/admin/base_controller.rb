class Api::V1::Admin::BaseController < Api::V1::BaseController
  before_action :authenticate_admin

  #TODO: add link to repo with admin panel SPA

  private

  def authenticate_admin
    token = request.headers['HTTP_REST_TOKEN'] || params[:rest_token] || request.headers['rest-token']
    @authenticated_admin = User.find_by(rest_token: token, role: ADMIN)
    render_fail(401, BASE_ERRORS[:invalid_token]) unless @authenticated_admin
  end
end