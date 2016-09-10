class Api::V1::DocController < ApplicationController
  before_action :check_permission, only: [:index, :logout]

  layout 'api_doc'

  def sign_in

  end

  def new_session
    email = user_params[:email].downcase if user_params[:email]
    login_failed = false

    if User.find_by(email: email).try(:role).in? [ADMIN, QA]
      user = login(email, user_params[:password], params[:remember])
      login_failed = true unless user
    else
      login_failed = true
    end

    if login_failed
      flash[:error] = 'Login failed'
      redirect_to action: 'sign_in'
    else
      flash[:notice] = 'Logged in successfully'
      redirect_back_or_to action: 'index'
    end
  end

  def delete_session

  end

  def index
  end

  private

  def check_permission
    unless current_user.try(:role).in? [ADMIN, QA]
      redirect_to action: 'sign_in'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :remember)
  end
end