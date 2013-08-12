ActiveAdmin.register User do
  scope :beginning
  scope :this_year
  scope :last_month
  scope :this_month
  scope :yesterday
  scope :today

  filter :id
  filter :email
  filter :uid
  filter :created_at

  index do
    column :id
    column :name
    column :email
    column :uid
    column :created_at

    default_actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name, as: :string
      f.input :email
      f.input :provider
      f.input :uid
      f.input :password
      f.input :password_confirmation
    end

    f.buttons
  end
end
