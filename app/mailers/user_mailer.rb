class UserMailer < ApplicationMailer
	default from: 'zakaz@poedemvtour.ru'

	def send_signup_email(link)
   	 @link = link

     mail(
      from: 'webmaster@poedemvtour.ru',
      to: 'admin@poedemvtour.ru',
      subject: 'Пользователь оставил отзыв на сайте poedemvtur.ru'
    )
  	end

  def buy_notification(email, options = {})
    email_template = EmailTemplate.find_by_slug('create_order')

    @content = MailContentParser.new(email_template, options).call

    mail(to: email, subject: email_template.subject)
	end

  def buy_notification_manager(email, options = {})
    email_template = EmailTemplate.find_by_slug('create_order_manager')

    @content = MailContentParser.new(email_template, options).call

    mail(to: email, subject: email_template.subject)
  end

  def feedback_phone(email, options = {})
    email_template = EmailTemplate.find_by_slug('feedback_phone')

    @content = MailContentParser.new(email_template, options).call

    mail(to: email, subject: email_template.subject)
  end
end
