ActiveAdmin.register Advert do
  filter :user
  filter :category
  filter :title
  filter :price
  filter :ad_status
  filter :created_at

  index do
    column :id
    column :title
    column :category
    column :price
    column :ad_status

    default_actions
  end

  show do
    panel 'Advert Details' do
      attributes_table_for advert do
        row :id
        row :category
        row :user
        row :title
        row :description
        row :price
        row :ad_status
        row :created_at
        row :updated_at
      end
    end

    panel 'Attachments' do
      table_for advert.attachments do
        column :description
        column 'File' do |att|
          "<img src='#{att.file}' width='150px'/>".html_safe
        end
      end
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :user
      f.input :category
      f.input :ad_status
      f.input :title
      f.input :description
      f.input :price
    end

    f.inputs 'Attachments' do
      f.has_many :attachments do |attachment|
        attachment.input :description, as: :string
        attachment.input :file, as: :file
        attachment.input :_destroy, :as => :boolean, :required => false, :label => 'Remove'
      end
    end

    f.buttons
  end
end
