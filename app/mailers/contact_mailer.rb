class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(
      from: ENV['TO_MAIL'],
      to: contact.email,
      subject: '【お問い合わせ・ご要望を承りました】',
      bcc: ENV['TO_MAIL']
    )
  end
end
