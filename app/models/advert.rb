class Advert < ActiveRecord::Base
  attr_accessible :user_id, :category_id, :title, :description, :price, :q_price_free, :q_price_negotiable,
  :attachments_attributes, :address_attributes, :ad_status_id
  belongs_to :user
  belongs_to :category
  belongs_to :ad_status
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :attachments, as: :attachable, dependent: :delete_all
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :drafts, where(q_draft: true)

  markable_as :favorite

  after_update :send_notification

  def self.create_from_cookies(user_id, cookies)
    advert = Advert.new
    advert.user_id = user_id
    advert.category_id = cookies[:rab_new_advert_category_id] if cookies[:rab_new_advert_category_id].present?
    advert.title = cookies[:rab_new_advert_title] if cookies[:rab_new_advert_title].present?
    advert.description = cookies[:rab_new_advert_description] if cookies[:rab_new_advert_description].present?
    advert.price = 0 if cookies[:rab_new_advert_price].present?
    advert.ad_status_id = AdStatus.find_by_name('DRAFT').id
    advert.save
  end

  def send_notification
    if self.ad_status_id_changed? && self.ad_status.name == 'REMOVED'
      notification = Notification.new({
        user_id: self.user_id,
        action: 'advert_remove',
        key: 'notification.advert.remove',
        notifiable_cache: "{advert_title: '#{self.title}'}"
      })

      notification.save
    end
  end
end
