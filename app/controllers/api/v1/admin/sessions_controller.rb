class Api::V1::Admin::SessionsController < Api::V1::Admin::BaseController
  include Api::V1::Admin::SessionsDoc

  skip_before_action :authenticate_admin, only: 'sign_in'

  def sign_in
    email = params[:email].downcase if params[:email]
    @authenticated_admin = login(email, params[:password])
    if @authenticated_admin && @authenticated_admin.admin?
      # Invalidate other sessions.
      @authenticated_admin.update_rest_token
    else
      render_fail(107, BASE_ERRORS[:invalid_credentials])
    end
  end

  def sign_out
    @authenticated_admin.update_rest_token
    render_success(200, {admin_logged_out: true})
  end
end