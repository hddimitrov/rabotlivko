angular.module('rab').controller('AdvertsCtrl', ['$scope', function($scope) {
  $scope.advert = {};
  $scope.new_advert_cookies_save = function() {
    console.log('new_advert_cookies_save')
    $.cookie('rab_new_advert_category_id', $scope.advert.category_id + '', {path: '/'});
    $.cookie('rab_new_advert_title', $scope.advert.title, {path: '/'});
    $.cookie('rab_new_advert_description', $scope.advert.description, {path: '/'});
    $.cookie('rab_new_advert_price_type', $scope.advert.price_type, {path: '/'});
    $.cookie('rab_new_advert_price', $scope.advert.price + '', {path: '/'});
    return true;
  };
}]);
