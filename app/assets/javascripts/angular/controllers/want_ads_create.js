angular.module('rab').controller('want_ads_create',
                                ['$scope', 'rabServices',
                                function($scope, rabServices) {

  $scope.continue = function() {
    $scope.continue_clicked = true;
    if($scope.want_ad.title && $scope.want_ad.category_id && $scope.want_ad.description) {
      $scope.current_step = 2;
    }
  };

  $scope.save_draft = function() {

  };

  $scope.new_advert_cookies_save = function() {
    console.log('new_want_ad_cookies_save');
    $.cookie('rab_new_want_ad_title', $scope.want_ad.title, {path: '/'});
    $.cookie('rab_new_want_ad_category_id', $scope.want_ad.category_id + '', {path: '/'});
    $.cookie('rab_new_want_ad_description', $scope.want_ad.description, {path: '/'});
    // $.cookie('rab_new_want_ad_price_type', $scope.want_ad.price_type, {path: '/'});
    // $.cookie('rab_new_want_ad_price', $scope.want_ad.price + '', {path: '/'});
    return true;
  };
}]);
