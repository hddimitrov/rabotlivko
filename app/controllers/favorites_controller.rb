class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def fav_advert
    advert = Advert.find_by_id(params[:advert_id])

    if advert.present?
      current_user.mark_as_favorite(advert)
    end

    render nothing: true
  end

  def unfav_advert
    advert = Advert.find_by_id(params[:advert_id])

    if advert.present?
      current_user.remove_mark :favorite, advert
    end

    render nothing: true
  end

  def fav_want_ad
    want_ad = WantAd.find_by_id(params[:want_ad_id])

    if want_ad.present?
      current_user.mark_as_favorite(want_ad)
    end

    render nothing: true
  end


  def unfav_want_ad
    want_ad = WantAd.find_by_id(params[:want_ad_id])

    if want_ad.present?
      current_user.remove_mark :favorite, want_ad
    end

    render nothing: true
  end

  def fav_user
    user = User.find_by_id(params[:user_id])

    if user.present?
      current_user.mark_as_favorite(user)
    end

    render nothing: true
  end

  def unfav_user
    user = User.find_by_id(params[:user_id])

    if user.present?
      current_user.remove_mark :favorite, user
    end

    render nothing: true
  end

  def follow_user
    user = User.find_by_id(params[:user_id])

    if user.present?
      current_user.mark_as_followed(user)
    end

    render nothing: true
  end

  def unfollow_user
    user = User.find_by_id(params[:user_id])

    if user.present?
      current_user.remove_mark :followed, user
    end

    render nothing: true
  end

  def block_user
    user = User.find_by_id(params[:user_id])

    if user.present?
      current_user.mark_as_blocked(user)
    end

    render nothing: true
  end

  def unblock_user
    user = User.find_by_id(params[:user_id])

    if user.present?
      current_user.remove_mark :blocked, user
    end

    render nothing: true
  end
end
