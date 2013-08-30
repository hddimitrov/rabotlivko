class WantAd < ActiveRecord::Base
  attr_accessible :deadline, :description, :category_id, :price, :title, :user_id, :ad_status_id,
                  :q_price_free, :q_price_negotiable, :attachments_attributes, :address_attributes


  belongs_to :user
  belongs_to :category
  belongs_to :ad_status
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :attachments, as: :attachable, dependent: :delete_all
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :drafts, joins(:ad_status).where('ad_statuses.name' => 'DRAFT')
  scope :active, joins(:ad_status).where('ad_statuses.name' => 'ACTIVE')
  scope :archived, joins(:ad_status).where('ad_statuses.name' => 'ARCHIVED')
  scope :removed, joins(:ad_status).where('ad_statuses.name' => 'REMOVED')

  markable_as :favorite

  after_update :send_notification

  def send_notification
    if self.ad_status_id_changed? && self.ad_status.name == 'REMOVED'
      notification = Notification.new({
        user_id: self.user_id,
        action: 'want_ad_remove',
        key: 'notification.want_ad.remove',
        notifiable_cache: "{want_ad_title: '#{self.title}'}"
      })

      notification.save
    end
  end
end
