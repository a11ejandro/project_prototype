class Api::V1::Admin::UsersController < Api::V1::Admin::BaseController
  before_action :set_current_user, only: [:show, :update, :destroy, :reset_password]

  include Api::V1::Admin::UsersDoc

  def update
    @current_user.assign_attributes(user_params)
    if @current_user.valid?
      @current_user.save
      render :show,  locals: {user: @current_user}
    else
      render_fail 422, @current_user.errors.full_messages.first
    end
  end

  def reset_password
    password = SecureRandom.hex(4)
    @current_user.update(password: password)
    UserMailer.send_new_password(@current_user, password).deliver_now!
    render_success(200, true)
  end

  def show
    render locals: {user: @current_user}
  end

  def destroy
    if @current_user.id == @authenticated_admin.id
      render_fail(403, 'Forbidden to delete own account')
    else
      @current_user.destroy
      render_success(200, true)
    end
  end

  def index
    @page = params[:page] || 1

    @per_page = params[:per_page] || 20

    @users = User.search_for(params[:search_phrase])
                 .order_by(params[:sort_field_name], params[:sort_order])
                 .paginate(page: @page, per_page: @per_page)

    @total_pages = @users.total_pages
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :role, :avatar)
  end

  def set_current_user
    @current_user = User.find_by(id: params[:id])
    render_fail(404, 'User not found') unless @current_user
  end
end