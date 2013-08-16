class Advert < ActiveRecord::Base
  attr_accessible :user_id, :category_id, :title, :description, :q_draft, :price, :q_price_free, :q_price_negotiable,
  :attachments_attributes
  belongs_to :user
  belongs_to :category
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :drafts, where(q_draft: true)

  markable_as :favorite

  def self.create_from_cookies(user_id, cookies)
    advert = Advert.new
    advert.user_id = user_id
    advert.category_id = cookies[:rab_new_advert_category_id] if cookies[:rab_new_advert_category_id].present?
    advert.title = cookies[:rab_new_advert_title] if cookies[:rab_new_advert_title].present?
    advert.description = cookies[:rab_new_advert_description] if cookies[:rab_new_advert_description].present?
    advert.price = 0 if cookies[:rab_new_advert_price].present?
    advert.q_draft = true
    advert.save
  end
end
