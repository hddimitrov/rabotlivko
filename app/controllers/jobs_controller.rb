class JobsController < ApplicationController
  before_filter :authenticate_user

  def get_want_ad_applications
    want_ad = WantAd.find_by_id(params[:want_ad_id])
    if want_ad.present? && want_ad.user_id == current_user.id
      applications = []
      want_ad.applications.each do |app|
        applications << {app_id: app.id,
          applicant_name: app.applicant.name,
          owner_status: app.owner_status,
          applicant_status: app.applicant_status}
      end
      render json: applications and return
    end
    render json: []
  end

  def set_want_ad_status_applicant
    want_ad = WantAd.find_by_id(params[:want_ad_id])
    if want_ad.present?
      app = want_ad.applications.find_or_initialize_by_applicant_id(current_user.id)
      app.applicant_status = params[:status]
      app.save
    end
    render nothing: true
  end

  def set_want_ad_status_owner
    app = Application.find_by_id(params[:application_id])
    if app.present? && app.applicable.user_id = current_user.id
      app.owner_status = params[:status]
      app.save
    end
    render nothing: true
  end

  def get_advert_applications
    advert = Advert.find_by_id(params[:id])
    if advert.present? && advert.user_id == current_user.id
      applications = []
      advert.applications.each do |app|
        applications << {app_id: app.id,
          applicant_name: app.applicant.name,
          owner_status: app.owner_status,
          applicant_status: app.applicant_status}
      end
      render json: applications and return
    end
    render json: []
  end

  def set_advert_status_applicant
    advert = Advert.find_by_id(params[:id])
    if advert.present?
      app = advert.applications.find_or_initialize_by_applicant_id(current_user.id)
      app.applicant_status = params[:status]
      app.save
    end
    render nothing: true
  end

  def set_advert_status_owner
    app = Application.find_by_id(params[:application_id])
    if app.present? && app.applicable.user_id = current_user.id
      app.owner_status = params[:status]
      app.save
    end
    render nothing: true
  end
end
