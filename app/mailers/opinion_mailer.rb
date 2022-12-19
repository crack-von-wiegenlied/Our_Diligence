class OpinionMailer < ApplicationMailer

  def opinion_notice
    @opinion = params[:opinion]
    mail(
    from: 'system@example.com',
    to:   'kmtisyi18rpg@gmail.com',
    subject: 'お問い合わせ通知'
    )
  end

end
