class JobsController < ApplicationController
  before_filter :authenticate_user!

  def applicant_status_want_ad
    want_ad = WantAd.find_by_id(params[:id])
    if want_ad.present?
      my_app = want_ad.applications.find_or_initialize_by_applicant_id(current_user.id)
      my_app.applicant_status = params[:status]
      my_app.save
    end
    render nothing: true
  end
end
