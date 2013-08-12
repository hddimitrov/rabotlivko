ActiveAdmin.register Advert do
  filter :user
  filter :category
  filter :title
  filter :price
  filter :q_draft, label: 'Draft'
  filter :q_price_free, label: 'Free'
  filter :q_price_negotiable, label: 'Negotiable'
  filter :created_at

  index do
    column :id
    column :title
    column :category
    column :price
    column 'Free' do |advert|
      advert.q_price_free ? 'YES' : 'NO'
    end
    column 'Negotiable' do |advert|
      advert.q_price_negotiable ? 'YES' : 'NO'
    end
    column 'Draft' do |advert|
      advert.q_draft ? 'YES' : 'NO'
    end

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
        row 'Free' do |advert|
          advert.q_price_free ? 'YES' : 'NO'
        end
        row 'Negotiable' do |advert|
          advert.q_price_negotiable ? 'YES' : 'NO'
        end
        row 'Draft' do |advert|
          advert.q_draft ? 'YES' : 'NO'
        end
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
      f.input :title
      f.input :description
      f.input :q_draft, label: 'Draft'
      f.input :price
      f.input :q_price_free, label: 'Free'
      f.input :q_price_negotiable, label: 'Negotiable'
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
