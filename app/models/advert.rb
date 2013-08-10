class Advert < ActiveRecord::Base
  attr_accessible :user_id, :category_id, :title, :description, :q_draft, :price, :q_price_free, :q_price_negotiable,
  :attachments_attributes
  belongs_to :user
  belongs_to :category
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments

  def create_from_cookies_info(cookies)
    advert = Advert.new
    advert.category_id = cookies[:rab_new_advert_category_id] if cookies[:rab_new_advert_category_id].present?
    advert.title = cookies[:rab_new_advert_title] if cookies[:rab_new_advert_title].present?
    advert.description = cookies[:rab_new_advert_description] if cookies[:rab_new_advert_description].present?
    advert.price = cookies[:rab_new_advert_price] if cookies[:rab_new_advert_price].present?
    advert.user_id
    advert.draft = true
    advert.save
  end
end
