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

  def flag_item(item_type, item_id, explanation)
    body = "В #{item_type} #{item_id} беше маркирана нередност! Моля проверете! \n\n"
    body += "Обяснение:\n"
    body += explanation

    mail subject: "FLAGGED #{item_type} #{item_id} from rabotazaden.com",
         body: body
  end
end
