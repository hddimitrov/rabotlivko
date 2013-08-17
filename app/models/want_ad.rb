class WantAd < ActiveRecord::Base
  attr_accessible :deadline, :description, :category_id, :q_draft, :price, :title, :user_id,
                  :q_price_free, :q_price_negotiable, :attachments_attributes, :address_attributes

  belongs_to :user
  belongs_to :category
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :attachments, as: :attachable, dependent: :delete_all
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :drafts, where(q_draft: true)
end
