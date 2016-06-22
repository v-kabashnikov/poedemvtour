class FeedbackController < ApplicationController
  def feedback_phone
    UserMailer.feedback_phone('office_m@poedemvtour.ru', params: params).deliver

    render nothing: true
  end

  def subscribe
    subscribe_email = SubscribeEmail.new(email: params[:email])

    if subscribe_email.save
      text = 'Подписка оформлена'
    else
      text = 'Ваш адрес уже подписан'
    end

    render text: text
  end
end
