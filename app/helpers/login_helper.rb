module LoginHelper
  include AdvertsHelper
  def sign_in_and(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    new_advert_cookies_check
  end
end
