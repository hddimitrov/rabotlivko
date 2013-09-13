class PagesController < ApplicationController

  def home
  end

  def about
  end

  def faq
  end

  def contacts
  end

  def contacts_map
    render partial: 'contacts_map'
  end
end
