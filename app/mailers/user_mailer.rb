class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def delete_email(user)
  	@user = user
    mail(to: @user.email, subject: 'User deleted')
  end

end
