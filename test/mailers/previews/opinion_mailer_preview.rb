# Preview all emails at http://localhost:3000/rails/mailers/opinion_mailer
class OpinionMailerPreview < ActionMailer::Preview
  def opinion
     opinion = Opinion.new(user_id: 1, title: "タイトル", body: "問い合わせメッセージ")

     OpinionMailer.opinion_notice(opinion)
  end
end
