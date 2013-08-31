class Application < ActiveRecord::Base
  attr_accessible :applicable_id, :applicable_type, :applicant_id, :applicant_status, :owner_status

  belongs_to :applicable, polymorphic: true
  belongs_to :applicant, class_name: 'User', foreign_key: :applicant_id

  after_update :send_notification



  def send_notification
    if self.owner_status? && self.owner_status.present?
      notification = Notification.new({
        user_id: self.applicant_id,
        action: "application_owner_#{self.owner_status}",
        key: "notification.application.owner.#{self.owner_status}",
        notifiable_cache: "{owner_name: '#{self.applicable.user.name}', ad_title: '#{self.applicable.title}'}"
      })

      notification.save
    end

    if self.applicant_status? && self.applicant_status.present?
      notification = Notification.new({
        user_id: self.applicable.user.id,
        action: "application_applicant_#{self.owner_status}",
        key: "notification.application.applicant.#{self.applicant_status}",
        notifiable_cache: "applicant_name: '#{self.applicant.name}', ad_title: '#{self.applicable.title}'}"
      })

      notification.save
    end
  end
end
