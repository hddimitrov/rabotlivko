module AdvertsHelper
  def new_advert_cookies_check
    puts '================================='
    puts cookies.inspect
    puts cookies[:rab_new_advert_title]
    puts '================================='
    if cookies[:rab_new_advert_title].present?
      Advert.create_from_cookies(current_user.id, cookies)
      new_advert_cookies_remove
    end
  end

  def new_advert_cookies_remove
    cookies.delete :rab_new_advert_category_id
    cookies.delete :rab_new_advert_title
    cookies.delete :rab_new_advert_description
    cookies.delete :rab_new_advert_price_type
    cookies.delete :rab_new_advert_price
  end
end
