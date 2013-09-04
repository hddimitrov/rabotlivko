class JobsController < ApplicationController
  before_filter :authenticate_user!

  def applicant_manage_want_ad_job
    want_ad = WantAd.find_by_id(params[:want_ad_id])
    if want_ad.present?
      app = want_ad.applications.find_or_initialize_by_applicant_id(current_user.id)
      app.applicant_status = params[:status]
      app.save
    end
    render nothing: true
  end

  def applicant_manage_advert_job
    advert = Advert.find_by_id(params[:advert_id])
    if advert.present?
      app = advert.applications.find_or_initialize_by_applicant_id(current_user.id)
      app.applicant_status = params[:status]
      app.save
    end
    render nothing: true
  end

  def owner_manage_job
    app = Application.find_by_id(params[:application_id])
    if app.present? && app.applicable.user_id = current_user.id
      app.owner_status = params[:status]
      app.save
    end
    render nothing: true
  end
end
