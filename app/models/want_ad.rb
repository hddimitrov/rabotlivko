class WantAd < ActiveRecord::Base
  attr_accessible :deadline, :description, :category_id, :q_draft, :price, :title, :user_id,
                  :q_price_free, :q_price_negotiable, :attachments_attributes

  belongs_to :user
  belongs_to :category
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :drafts, where(q_draft: true)

  markable_as :favorite
end
