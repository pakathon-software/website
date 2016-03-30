class Mailer < ActionMailer::Base
  default from: "hiqbaldev@gmail.com"
  
  def thankyou_email(username, email)
    @username = username
    mail(to: email, subject: 'Thank you! :)')
  end
end