class TestMailer < ActionMailer::Base
  def email_name
    mail subject: "Mandrill rides the Rails!",
         to: "hristopeev@gmail.com",
         from: "contact@rabotazaden.com",
         body: 'Awesome I am working!'
  end
end
