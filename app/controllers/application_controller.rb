class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Exception, with: :handle_exceptions

  helper_method :date_filter

  private

  def date_filter
    date = (Time.now + 3.days).to_date

    date.strftime('%d') + Russian.strftime(date, '%B').mb_chars.capitalize[0..2].to_s
  end

  def handle_exceptions(e)
    ErrorMailer.experror(e).deliver

    render file: 'public/500.html', layout: false, status: 500
  end
end
