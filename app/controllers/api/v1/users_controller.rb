class Api::V1::UsersController < Api::V1::BaseController
  include Api::V1::UsersDoc

  before_action :authorize_token, except: [:reset_password]
  before_action :authorize_user, only: [:update]
  before_action :check_password, only: [:update, :destroy]
  before_action :set_current_user, only: [:show]

  def update
    @authenticated_user.assign_attributes(user_params)
    if @authenticated_user.valid?
      @authenticated_user.save
      render :show,  locals: {user: @authenticated_user}
    else
      render_fail 422, @authenticated_user.errors.full_messages.first
    end
  end

  def reset_password
    params[:email] = params[:email].downcase if params[:email]
    user = User.find_by(email: params[:email])
    if user
        password = SecureRandom.hex(4)
        user.update(password: password)
        UserMailer.send_new_password(user, password).deliver_now!
        render_success(200, true)
    else
      render_fail(404, 'User with credentials not found')
    end
  end

  def show
    render locals: {user: @current_user}
  end

  def update_password
    return render_fail(403, 'Password confirmation required') unless params[:old_password]

    if @authenticated_user.valid_password?(params[:old_password])
      @authenticated_user.assign_attributes(password: params[:new_password])
      if @authenticated_user.valid?
        @authenticated_user.save
        render template: 'api/v1/sessions/sign_in', locals: {user: @authenticated_user}
      else
        render_fail(403, 'Invalid credentials')
      end
    else
      render_fail(401, BASE_ERRORS[:invalid_token])
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :avatar)
  end
  
  def check_password
    user = login(@authenticated_user.email, params[:password])

    unless user
      render_fail(401, BASE_ERRORS[:invalid_password])
    end
  end

  def authorize_user
    # allow updates only for own account
    render_fail(405, BASE_ERRORS[:no_edit_permissions]) unless params[:id] == @authenticated_user.id.to_s
  end

  def set_current_user
    @current_user = User.find_by(id: params[:id])
    render_fail(404, 'User not found') unless @current_user
  end
end