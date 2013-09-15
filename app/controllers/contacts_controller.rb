# encoding: UTF-8

class ContactsController < ApplicationController
  def ask_question
    if params[:email].present? and params[:message].present?
      SystemMailer.ask_question(params[:email], params[:message]).deliver
    end

    redirect_to page_faq_path, alert: 'Въпросът Ви е изпратен.'
  end

  def flag_item
    if params[:item_type].present? and params[:item_id].present? and params[:explanation].present?
      SystemMailer.flag_item(params[:item_type], params[:item_id], params[:explanation]).deliver
    end

    redirect_to send("#{params[:item_type]}_path", params[:item_id])
  end
end
