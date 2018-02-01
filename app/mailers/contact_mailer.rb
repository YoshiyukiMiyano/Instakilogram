class ContactMailer < ApplicationMailer
  def contact_mail(email)

    p email
 
    mail to: email, subject: "投稿完了"
  end
end
