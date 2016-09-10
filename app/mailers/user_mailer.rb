class UserMailer < ActionMailer::Base
  default from: Rails.application.secrets.current_base_url

  def password_recovery(user, token)
    @token = token
    @user = user

    mail to: @user.email, subject: "Recover password at Project_Prototype"
  end

  def send_new_password(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: "New password at Project_Prototype"
  end

  def send_email_from_campaign(user, message)
    @user = user
    @message = message
    mail to: @user.email, subject: "Project_Prototype"
  end
end