class Notification < ActiveRecord::Base
  attr_accessible :action, :key, :notifiable_cache, :notifiable_id, :notifiable_type, :q_notified, :user_id

  class_attribute :template
  self.template = YAML.load_file("#{Rails.root}/config/locales/views/notifications/bg.yml")

  belongs_to :user

  scope :unnotified, (where q_notified: false).order{id.desc}

  def text(params = {})
    begin
      erb_template = resolveTemplate(key)
      if erb_template
        parameters = eval(notifiable_cache)
        parameters.merge! params
        renderer = ERB.new(erb_template)
        renderer.result(binding)
      else
        "Template not defined"
      end
    rescue
      "Template not defined"
    end
  end

  def resolveTemplate(key)
    res = nil
    if self.template
      key.split(".").each do |k|
        res = (res ? res[k] : self.template[k])
      end
    end
    res
  end
end
