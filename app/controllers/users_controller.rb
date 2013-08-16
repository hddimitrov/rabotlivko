class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])

    adverts = @user.adverts
    want_ads = @user.want_ads

    @adverts_active     = adverts.select {|advert| advert.q_draft == false }
    @advert_drafts      = adverts.select {|advert| advert.q_draft }
    @fav_adverts        = current_user.favorite_adverts

    @wanted_ads_active  = want_ads.select {|want_ad| want_ad.q_draft == false && want_ad.deadline >= Date.today}
    @wanted_ads_archive = want_ads.select {|want_ad| want_ad.deadline < Date.today }
    @wanted_ad_drafts   = want_ads.select {|want_ad| want_ad.q_draft }
    @fav_want_ads       = current_user.favorite_wantads
  end

  def profile_master
    redirect_to user_path(current_user.id)
  end
end
