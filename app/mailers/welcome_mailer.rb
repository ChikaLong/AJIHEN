class WelcomeMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.welcome_mail.subject
  #
  def welcome_mail(email, name)
    @name = name
    @email = email
    mail to: email, subject: "AJIHENアカウント登録完了メール"
  end
end
