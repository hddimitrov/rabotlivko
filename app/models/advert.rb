class Advert < ActiveRecord::Base
  attr_accessible :category_id, :description, :draft, :price, :title, :user_id, :attachments_attributes
  belongs_to :user
  belongs_to :category
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments
end
