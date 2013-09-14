# encoding: UTF-8

class ContactsController < ApplicationController
  def ask_question
    if params[:email].present? and params[:message].present?
      SystemMailer.ask_question(params[:email], params[:message]).deliver
    end

    redirect_to page_faq_path, alert: 'Въпросът Ви е изпратен.'
  end
end
