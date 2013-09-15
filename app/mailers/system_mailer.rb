# encoding: UTF-8

class SystemMailer < ActionMailer::Base
  default from: "contact@rabotazaden.com"
  default to: "contact@rabotazaden.com"

  def ask_question(email, question)
    body = "От: #{email}\n\n"
    body += question

    mail subject: "FAQ rabotazaden.com",
         body: body
  end
end
