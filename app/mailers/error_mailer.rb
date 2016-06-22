class ErrorMailer < ApplicationMailer
  default from: 'zakaz@poedemvtour.ru'

  def experror(e)
    @err = e

    mail(to: ErrorSubscribe.pluck(:email), subject: 'poedemvtour - ошибка 500')
  end
end
